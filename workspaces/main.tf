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
  queue_all_runs                = true
  speculative_enabled           = true
  structured_run_output_enabled = true
  
  # VCS configuration for GitHub App integration
  vcs_repo {
    identifier                 = var.github_repository
    branch                     = var.vcs_branch
    github_app_installation_id = var.github_app_installation_id
  }
  
  # Set working directory for Terraform runs
  working_directory = var.working_directory
}

# Create a variable set for TFE credentials
data "tfe_variable_set" "aws_credentials" {
  name         = "aws-credentials"
  organization = data.tfe_organization.org.name
}


# Apply the variable set to the workspace
resource "tfe_workspace_variable_set" "aws_credentials_assignment" {
  variable_set_id = data.tfe_variable_set.aws_credentials.id
  workspace_id    = tfe_workspace.ansible_hcp_demo.id
}


# Data source to reference the existing workspace-management workspace
data "tfe_workspace" "workspace_management" {
  name         = "workspace-management"
  organization = data.tfe_organization.org.name
}

# Import the existing workspace-management workspace
import {
  to = tfe_workspace.workspace_management
  id = data.tfe_workspace.workspace_management.id
}

# Create the workspace-management workspace for managing workspaces
resource "tfe_workspace" "workspace_management" {
  name                          = "workspace-management"
  organization                  = data.tfe_organization.org.name
  project_id                    = data.tfe_project.project.id
  description                   = "Workspace for managing other HCP workspaces"
  tag_names                     = ["workspace-management", "infrastructure", "terraform"]
  auto_apply                    = true
  file_triggers_enabled         = false
  queue_all_runs                = true
  speculative_enabled           = true
  structured_run_output_enabled = true
  
  # VCS configuration for GitHub App integration
  vcs_repo {
    identifier                 = var.github_repository
    branch                     = var.vcs_branch
    github_app_installation_id = var.github_app_installation_id
  }
  
  # Set working directory for workspace management
  working_directory = "workspaces"
}

# Create a variable set for TFE credentials
data "tfe_variable_set" "tfe_credentials" {
  name         = "tfe-credentials"
  organization = data.tfe_organization.org.name
}

# Apply the TFE credentials variable set to the workspace-management workspace
resource "tfe_workspace_variable_set" "tfe_credentials_assignment" {
  variable_set_id = data.tfe_variable_set.tfe_credentials.id
  workspace_id    = tfe_workspace.workspace_management.id
}
