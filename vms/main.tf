terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ==> Multiple AWS Providers (one per region) <==
provider "aws" {
  alias      = "us_east_1"
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "aws" {
  alias      = "eu_central_1"
  region     = "eu-central-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "aws" {
  alias      = "eu_west_1"
  region     = "eu-west-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# ==> VPCs (us-east-1) <==
resource "aws_vpc" "main_us_east_1" {
  provider = aws.us_east_1
  
  cidr_block           = var.vpc_cidr_blocks["us-east-1"]
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name   = "fedora-vm-vpc-us-east-1"
    Region = "us-east-1"
  }
}

# ==> VPCs (eu-central-1) <==
resource "aws_vpc" "main_eu_central_1" {
  provider = aws.eu_central_1
  
  cidr_block           = var.vpc_cidr_blocks["eu-central-1"]
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name   = "fedora-vm-vpc-eu-central-1"
    Region = "eu-central-1"
  }
}

# ==> VPCs (eu-west-1) <==
resource "aws_vpc" "main_eu_west_1" {
  provider = aws.eu_west_1
  
  cidr_block           = var.vpc_cidr_blocks["eu-west-1"]
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name   = "fedora-vm-vpc-eu-west-1"
    Region = "eu-west-1"
  }
}

# ==> Internet Gateways <==
resource "aws_internet_gateway" "gw_us_east_1" {
  provider = aws.us_east_1
  vpc_id   = aws_vpc.main_us_east_1.id

  tags = {
    Name   = "fedora-vm-igw-us-east-1"
    Region = "us-east-1"
  }
}

resource "aws_internet_gateway" "gw_eu_central_1" {
  provider = aws.eu_central_1
  vpc_id   = aws_vpc.main_eu_central_1.id

  tags = {
    Name   = "fedora-vm-igw-eu-central-1"
    Region = "eu-central-1"
  }
}

resource "aws_internet_gateway" "gw_eu_west_1" {
  provider = aws.eu_west_1
  vpc_id   = aws_vpc.main_eu_west_1.id

  tags = {
    Name   = "fedora-vm-igw-eu-west-1"
    Region = "eu-west-1"
  }
}

# ==> Availability Zones data sources <==
data "aws_availability_zones" "available_us_east_1" {
  provider = aws.us_east_1
  state    = "available"
}

data "aws_availability_zones" "available_eu_central_1" {
  provider = aws.eu_central_1
  state    = "available"
}

data "aws_availability_zones" "available_eu_west_1" {
  provider = aws.eu_west_1
  state    = "available"
}

# ==> Public Subnets <==
resource "aws_subnet" "public_us_east_1" {
  provider = aws.us_east_1
  
  vpc_id                  = aws_vpc.main_us_east_1.id
  cidr_block              = var.subnet_cidr_blocks["us-east-1"]
  availability_zone       = data.aws_availability_zones.available_us_east_1.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name   = "fedora-vm-public-subnet-us-east-1"
    Region = "us-east-1"
  }
}

resource "aws_subnet" "public_eu_central_1" {
  provider = aws.eu_central_1
  
  vpc_id                  = aws_vpc.main_eu_central_1.id
  cidr_block              = var.subnet_cidr_blocks["eu-central-1"]
  availability_zone       = data.aws_availability_zones.available_eu_central_1.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name   = "fedora-vm-public-subnet-eu-central-1"
    Region = "eu-central-1"
  }
}

resource "aws_subnet" "public_eu_west_1" {
  provider = aws.eu_west_1
  
  vpc_id                  = aws_vpc.main_eu_west_1.id
  cidr_block              = var.subnet_cidr_blocks["eu-west-1"]
  availability_zone       = data.aws_availability_zones.available_eu_west_1.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name   = "fedora-vm-public-subnet-eu-west-1"
    Region = "eu-west-1"
  }
}

# ==> Route Tables for Public Subnets <==
resource "aws_route_table" "public_us_east_1" {
  provider = aws.us_east_1
  vpc_id   = aws_vpc.main_us_east_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_us_east_1.id
  }

  tags = {
    Name   = "fedora-vm-public-rt-us-east-1"
    Region = "us-east-1"
  }
}

resource "aws_route_table" "public_eu_central_1" {
  provider = aws.eu_central_1
  vpc_id   = aws_vpc.main_eu_central_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_eu_central_1.id
  }

  tags = {
    Name   = "fedora-vm-public-rt-eu-central-1"
    Region = "eu-central-1"
  }
}

resource "aws_route_table" "public_eu_west_1" {
  provider = aws.eu_west_1
  vpc_id   = aws_vpc.main_eu_west_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_eu_west_1.id
  }

  tags = {
    Name   = "fedora-vm-public-rt-eu-west-1"
    Region = "eu-west-1"
  }
}

# ==> Route Table Associations <==
resource "aws_route_table_association" "public_us_east_1" {
  provider = aws.us_east_1
  
  subnet_id      = aws_subnet.public_us_east_1.id
  route_table_id = aws_route_table.public_us_east_1.id
}

resource "aws_route_table_association" "public_eu_central_1" {
  provider = aws.eu_central_1
  
  subnet_id      = aws_subnet.public_eu_central_1.id
  route_table_id = aws_route_table.public_eu_central_1.id
}

resource "aws_route_table_association" "public_eu_west_1" {
  provider = aws.eu_west_1
  
  subnet_id      = aws_subnet.public_eu_west_1.id
  route_table_id = aws_route_table.public_eu_west_1.id
}

# ==> Security Groups <==
resource "aws_security_group" "allow_ssh_us_east_1" {
  provider = aws.us_east_1
  
  name        = "allow-ssh-fedora-us-east-1"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main_us_east_1.id

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
    Name   = "allow-ssh-fedora-sg-us-east-1"
    Region = "us-east-1"
  }
}

resource "aws_security_group" "allow_ssh_eu_central_1" {
  provider = aws.eu_central_1
  
  name        = "allow-ssh-fedora-eu-central-1"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main_eu_central_1.id

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
    Name   = "allow-ssh-fedora-sg-eu-central-1"
    Region = "eu-central-1"
  }
}

resource "aws_security_group" "allow_ssh_eu_west_1" {
  provider = aws.eu_west_1
  
  name        = "allow-ssh-fedora-eu-west-1"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main_eu_west_1.id

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
    Name   = "allow-ssh-fedora-sg-eu-west-1"
    Region = "eu-west-1"
  }
}

# ==> EC2 Key Pairs <==
resource "aws_key_pair" "vm_auth_us_east_1" {
  provider = aws.us_east_1
  
  key_name   = "${var.key_pair_name}-us-east-1"
  public_key = var.user_public_key

  tags = {
    Name   = "${var.key_pair_name}-us-east-1"
    Region = "us-east-1"
  }
}

resource "aws_key_pair" "vm_auth_eu_central_1" {
  provider = aws.eu_central_1
  
  key_name   = "${var.key_pair_name}-eu-central-1"
  public_key = var.user_public_key

  tags = {
    Name   = "${var.key_pair_name}-eu-central-1"
    Region = "eu-central-1"
  }
}

resource "aws_key_pair" "vm_auth_eu_west_1" {
  provider = aws.eu_west_1
  
  key_name   = "${var.key_pair_name}-eu-west-1"
  public_key = var.user_public_key

  tags = {
    Name   = "${var.key_pair_name}-eu-west-1"
    Region = "eu-west-1"
  }
}