terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ==> AWS Providers for all regions <==
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

# ==> Regional Infrastructure Modules <==
module "us_east_1" {
  source = "./modules/aws-region"
  count  = contains(var.aws_regions, "us-east-1") ? 1 : 0

  providers = {
    aws = aws.us_east_1
  }

  region             = "us-east-1"
  vpc_cidr_block     = var.vpc_cidr_blocks["us-east-1"]
  subnet_cidr_block  = var.subnet_cidr_blocks["us-east-1"]
  instance_type      = var.instance_type
  ami_id             = var.ami_ids["us-east-1"]
  user_public_key    = var.user_public_key
  key_pair_name      = var.key_pair_name
}

module "eu_central_1" {
  source = "./modules/aws-region"
  count  = contains(var.aws_regions, "eu-central-1") ? 1 : 0

  providers = {
    aws = aws.eu_central_1
  }

  region             = "eu-central-1"
  vpc_cidr_block     = var.vpc_cidr_blocks["eu-central-1"]
  subnet_cidr_block  = var.subnet_cidr_blocks["eu-central-1"]
  instance_type      = var.instance_type
  ami_id             = var.ami_ids["eu-central-1"]
  user_public_key    = var.user_public_key
  key_pair_name      = var.key_pair_name
}

module "eu_west_1" {
  source = "./modules/aws-region"
  count  = contains(var.aws_regions, "eu-west-1") ? 1 : 0

  providers = {
    aws = aws.eu_west_1
  }

  region             = "eu-west-1"
  vpc_cidr_block     = var.vpc_cidr_blocks["eu-west-1"]
  subnet_cidr_block  = var.subnet_cidr_blocks["eu-west-1"]
  instance_type      = var.instance_type
  ami_id             = var.ami_ids["eu-west-1"]
  user_public_key    = var.user_public_key
  key_pair_name      = var.key_pair_name
}