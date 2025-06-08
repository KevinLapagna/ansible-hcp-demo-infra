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

variable "workspace_name" {
  description = "The name of the HCP workspace to create"
  type        = string
}

# AWS credentials variables
variable "aws_access_key" {
  description = "AWS Access Key ID"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
}
