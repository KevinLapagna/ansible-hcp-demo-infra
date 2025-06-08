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

# Data source to get the project
data "tfe_project" "project" {
  name         = var.project_name
  organization = data.tfe_organization.org.name
}

# Create the HCP workspace
resource "tfe_workspace" "ansible_hcp_demo" {
  name                          = var.workspace_name
  organization                  = data.tfe_organization.org.name
  project_id                    = data.tfe_project.project.id
  description                   = "Ansible HCP demonstration workspace"
  tag_names                     = ["ansible", "hcp", "demo"]
  auto_apply                    = true
  file_triggers_enabled         = false
  queue_all_runs               = true
  speculative_enabled          = true
  structured_run_output_enabled = true
  
  # VCS configuration for GitHub App integration
  vcs_repo {
    identifier                 = var.github_repository
    branch                    = var.vcs_branch
    github_app_installation_id = var.github_app_installation_id
  }
  
  # Set working directory for Terraform runs
  working_directory = var.working_directory
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

# Apply the variable set to the workspace
resource "tfe_workspace_variable_set" "aws_credentials_assignment" {
  variable_set_id = tfe_variable_set.aws_credentials.id
  workspace_id    = tfe_workspace.ansible_hcp_demo.id
}
