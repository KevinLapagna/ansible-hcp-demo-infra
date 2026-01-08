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
resource "aws_security_group" "allow_inbound" {
  name        = "allow-inbound-rhel-${var.region}"
  description = "Allow SSH, HTTP, and HTTPS inbound traffic"
  vpc_id      = aws_vpc.main.id

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: Allows SSH from ANY IP. Restrict this for production.
    description = "SSH"
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  # HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "allow-inbound-rhel-sg-${var.region}"
    Region = var.region
  }
}

# ==> Windows WinRM Security Group <==
resource "aws_security_group" "windows_winrm_sg" {
  name        = "windows-winrm-sg-${var.region}"
  description = "Allow WinRM HTTPS/HTTP and RDP for debugging"
  vpc_id      = aws_vpc.main.id

  # WinRM HTTPS (5986) - Certificate authentication
  ingress {
    from_port   = 5986
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "WinRM HTTPS (Certificate authentication)"
  }

  # WinRM HTTP (5985) - For debugging (username/password authentication)
  ingress {
    from_port   = 5985
    to_port     = 5985
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "WinRM HTTP (Username/password authentication for debugging)"
  }

  # RDP (3389) - For debugging
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "RDP for debugging"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "windows-winrm-rdp-debug-sg-${var.region}"
    Environment = "Development"
    Region      = var.region
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


