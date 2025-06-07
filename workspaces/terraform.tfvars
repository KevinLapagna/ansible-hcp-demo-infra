# Terraform Cloud/Enterprise Configuration
tfe_hostname = "app.terraform.io"
# tfe_token = "your-terraform-cloud-api-token"  # Set via environment variable TF_VAR_tfe_token

# Organization and Project Configuration
organization_name = "lennart-org"
project_name      = "RH_HCP"
workspace_name    = "ansible-hcp-demo-02"

# VCS Integration Configuration (GitHub App)
github_app_installation_id = "ghain-Ror8fM2oXMAMRJoc"
github_repository = "KevinLapagna/ansible-hcp-demo-infra"
vcs_branch        = "main"
working_directory = "vms"
