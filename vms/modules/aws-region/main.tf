terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ==> VPC <==
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name   = "fedora-vm-vpc-${var.region}"
    Region = var.region
  }
}

# ==> Internet Gateway <==
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name   = "fedora-vm-igw-${var.region}"
    Region = var.region
  }
}

# ==> Availability Zones data source <==
data "aws_availability_zones" "available" {
  state = "available"
}

# ==> Public Subnet <==
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name   = "fedora-vm-public-subnet-${var.region}"
    Region = var.region
  }
}

# ==> Route Table for Public Subnet <==
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name   = "fedora-vm-public-rt-${var.region}"
    Region = var.region
  }
}

# ==> Route Table Association <==
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# ==> Security Group <==
resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh-fedora-${var.region}"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

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
    Name   = "allow-ssh-fedora-sg-${var.region}"
    Region = var.region
  }
}

# ==> EC2 Key Pair <==
resource "aws_key_pair" "vm_auth" {
  key_name   = "${var.key_pair_name}-${var.region}"
  public_key = var.user_public_key

  tags = {
    Name   = "${var.key_pair_name}-${var.region}"
    Region = var.region
  }
}


