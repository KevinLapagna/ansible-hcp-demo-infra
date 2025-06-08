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

# Add aws credentials variable set to project
data "tfe_variable_set" "aws_credentials" {
  name         = "aws-credentials"
  organization = data.tfe_organization.org.name
}

resource "tfe_project_variable_set" "aws_credentials_assignment" {
  variable_set_id = data.tfe_variable_set.aws_credentials.id
  project_id    = data.tfe_project.project.id
}

# Create the HCP workspace
resource "tfe_workspace" "ansible_hcp_demo" {
  name                          = "ansible-hcp-demo-ec2-vms"
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
    identifier                 = "KevinLapagna/ansible-hcp-demo-infra"
    branch                     = "main"
    github_app_installation_id = var.github_app_installation_id
  }
  
  # Set working directory for Terraform runs
  working_directory = "vms"
}