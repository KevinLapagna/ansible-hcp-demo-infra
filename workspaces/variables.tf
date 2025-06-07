variable "tfe_hostname" {
  description = "The hostname of the Terraform Cloud/Enterprise instance"
  type        = string
  default     = "app.terraform.io"
}

variable "tfe_token" {
  description = "The API token for Terraform Cloud/Enterprise"
  type        = string
  sensitive   = true
}

variable "organization_name" {
  description = "The name of the Terraform Cloud organization"
  type        = string
}

variable "project_name" {
  description = "The name of the HCP project"
  type        = string
}

variable "workspace_name" {
  description = "The name of the HCP workspace to create"
  type        = string
}

variable "github_app_installation_id" {
  description = "The GitHub App installation ID for VCS integration"
  type        = string
}

variable "github_repository" {
  description = "The GitHub repository identifier (owner/repo)"
  type        = string
}

variable "vcs_branch" {
  description = "The VCS branch to use for the workspace"
  type        = string
  default     = "main"
}

variable "working_directory" {
  description = "The working directory for Terraform runs"
  type        = string
  default     = ""
}
