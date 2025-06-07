terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

terraform { 
  cloud { 
    
    organization = "lennart-org" 

    workspaces { 
      name = "kev-workspace-01" 
    } 
  } 
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# ==> VPC <==
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "fedora-vm-vpc"
  }
}

# ==> Internet Gateway <==
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "fedora-vm-igw"
  }
}

# ==> Public Subnet <==
# If var.availability_zone is empty, AWS will choose an AZ in the VPC's region.
# For more control, you can specify it or use a data source to select one.
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.availability_zone == "" ? data.aws_availability_zones.available.names[0] : var.availability_zone
  map_public_ip_on_launch = true # Instances launched in this subnet will get a public IP

  tags = {
    Name = "fedora-vm-public-subnet"
  }
}

# ==> Route Table for Public Subnet <==
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" # Route all traffic to the Internet Gateway
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "fedora-vm-public-rt"
  }
}

# ==> Route Table Association <==
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# ==> Security Group  <==
resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh-fedora"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id # Specify the VPC ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: Allows SSH from ANY IP. Restrict this for production.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh-fedora-sg" # Appended -sg to distinguish if needed
  }
}

# ==> EC2 Key Pair <==
resource "aws_key_pair" "vm_auth" {
  key_name   = var.key_pair_name
  public_key = var.user_public_key

  tags = {
    Name = var.key_pair_name
  }
}