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