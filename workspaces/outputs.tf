output "workspace_id" {
  description = "The ID of the created workspace"
  value       = tfe_workspace.ansible_hcp_demo.id
}

output "workspace_name" {
  description = "The name of the created workspace"
  value       = tfe_workspace.ansible_hcp_demo.name
}

output "workspace_url" {
  description = "The URL of the created workspace"
  value       = "https://${var.tfe_hostname}/app/${var.organization_name}/workspaces/${tfe_workspace.ansible_hcp_demo.name}"
}

output "organization_name" {
  description = "The organization name"
  value       = data.tfe_organization.org.name
}

output "project_name" {
  description = "The project name"
  value       = data.tfe_project.project.name
}

output "vcs_repository" {
  description = "The connected VCS repository"
  value       = var.github_repository
}

output "vcs_branch" {
  description = "The VCS branch used by the workspace"
  value       = var.vcs_branch
}

output "working_directory" {
  description = "The working directory for Terraform runs"
  value       = var.working_directory
}

# Workspace Management outputs
output "workspace_management_id" {
  description = "The ID of the workspace-management workspace"
  value       = tfe_workspace.workspace_management.id
}

output "workspace_management_name" {
  description = "The name of the workspace-management workspace"
  value       = tfe_workspace.workspace_management.name
}

output "workspace_management_url" {
  description = "The URL of the workspace-management workspace"
  value       = "https://${var.tfe_hostname}/app/${var.organization_name}/workspaces/${tfe_workspace.workspace_management.name}"
}
