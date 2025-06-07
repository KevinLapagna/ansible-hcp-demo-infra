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
  default     = "lennart-org"
}

variable "project_name" {
  description = "The name of the HCP project"
  type        = string
  default     = "RH_HCP"
}

variable "workspace_name" {
  description = "The name of the HCP workspace to create"
  type        = string
  default     = "ansible-hcp-demo-02"
}

variable "oauth_token_id" {
  description = "The OAuth token ID for VCS integration (optional)"
  type        = string
  default     = null
}
