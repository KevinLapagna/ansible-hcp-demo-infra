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

# Create the workspace-management workspace for managing workspaces
resource "tfe_workspace" "workspace_management" {
  name                          = var.workspace_name
  organization                  = data.tfe_organization.org.name
  project_id                    = data.tfe_project.project.id
  description                   = "Workspace for managing other HCP workspaces"
  tag_names                     = ["workspace-management", "infrastructure", "terraform"]
  auto_apply                    = true
  file_triggers_enabled         = true
  working_directory             = var.working_directory
  trigger_patterns              = ["${var.working_directory}/**/*"]
  queue_all_runs                = true
  speculative_enabled           = true
  structured_run_output_enabled = true
  
  # VCS configuration for GitHub App integration
  vcs_repo {
    identifier                 = var.github_repository
    branch                     = var.vcs_branch
    github_app_installation_id = var.github_app_installation_id
  }
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

# Apply the TFE credentials variable set to the workspace-management workspace
resource "tfe_workspace_variable_set" "tfe_credentials_assignment" {
  variable_set_id = tfe_variable_set.tfe_credentials.id
  workspace_id    = tfe_workspace.workspace_management.id
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
