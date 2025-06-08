terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.58.0"
    }
  }
}

# Configure the Terraform Cloud/Enterprise Provider
provider "tfe" {
  hostname = var.tfe_hostname
  token    = var.tfe_token
}

# Data source to get the organization
data "tfe_organization" "org" {
  name = var.organization_name
}

# Create a variable set for AWS credentials
resource "tfe_variable_set" "aws_credentials" {
  name         = "aws-credentials"
  description  = "AWS access credentials for infrastructure provisioning"
  organization = data.tfe_organization.org.name
}

# AWS Access Key variable
resource "tfe_variable" "aws_access_key" {
  key             = "aws_access_key"
  value           = var.aws_access_key
  category        = "terraform"
  description     = "AWS Access Key ID"
  sensitive       = true
  variable_set_id = tfe_variable_set.aws_credentials.id
}

# AWS Secret Key variable
resource "tfe_variable" "aws_secret_key" {
  key             = "aws_secret_key"
  value           = var.aws_secret_key
  category        = "terraform"
  description     = "AWS Secret Access Key"
  sensitive       = true
  variable_set_id = tfe_variable_set.aws_credentials.id
}

# Create a variable set for TFE credentials
resource "tfe_variable_set" "tfe_credentials" {
  name         = "tfe-credentials"
  description  = "Terraform Cloud/Enterprise credentials for workspace management"
  organization = data.tfe_organization.org.name
}

# TFE hostname variable
resource "tfe_variable" "tfe_hostname" {
  key             = "tfe_hostname"
  value           = var.tfe_hostname
  category        = "terraform"
  description     = "The hostname of the Terraform Cloud/Enterprise instance"
  sensitive       = false
  variable_set_id = tfe_variable_set.tfe_credentials.id
}

# TFE token variable
resource "tfe_variable" "tfe_token" {
  key             = "tfe_token"
  value           = var.tfe_token
  category        = "terraform"
  description     = "The API token for Terraform Cloud/Enterprise"
  sensitive       = true
  variable_set_id = tfe_variable_set.tfe_credentials.id
}