# Organization and Project Configuration
organization_name = "lennart-org"
project_name      = "RH_HCP"
workspace_name    = "ansible-hcp-demo-02"  # For VMs workspace

# Note: This configuration creates TWO workspaces:
# 1. ansible-hcp-demo-02 (for managing VMs in /vms directory)
# 2. workspace-management (for managing workspaces in /workspaces directory)

# VCS Integration Configuration (GitHub App)
github_app_installation_id = "ghain-Ror8fM2oXMAMRJoc"
github_repository = "KevinLapagna/ansible-hcp-demo-infra"
vcs_branch        = "main"
working_directory = "vms"
