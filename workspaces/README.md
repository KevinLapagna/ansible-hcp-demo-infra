# Terraform HCP Workspace Management

This directory contains Terraform configuration for managing HCP (HashiCorp Cloud Platform) workspaces using the Terraform Cloud provider.

## Overview

This configuration creates and manages a Terraform Cloud workspace named "ansible-hcp-demo-02" within the "lennart-org" organization under the "RH_HCP" project.

## Files

- `main.tf`: Main Terraform configuration with provider setup and workspace resource
- `variables.tf`: Variable definitions for configuration
- `outputs.tf`: Output values for the created workspace
- `terraform.tfvars`: Variable values (API token should be set via environment variable)

## Prerequisites

1. **Terraform Cloud API Token**: You need a valid Terraform Cloud API token with permissions to create workspaces
2. **Organization Access**: Access to the "lennart-org" organization
3. **Project Access**: The "RH_HCP" project must exist in the organization

## Usage

1. **Set your API token** (recommended via environment variable):
   ```bash
   export TF_VAR_tfe_token="your-terraform-cloud-api-token"
   ```
   
   Alternatively, you can uncomment and set the `tfe_token` in `terraform.tfvars`

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Plan the deployment**:
   ```bash
   terraform plan
   ```

4. **Apply the configuration**:
   ```bash
   terraform apply
   ```

## Configuration Details

### Workspace Configuration
- **Name**: ansible-hcp-demo-02
- **Organization**: lennart-org
- **Project**: RH_HCP
- **Description**: Ansible HCP demonstration workspace
- **Tags**: ansible, hcp, demo
- **Auto Apply**: Disabled (manual approval required)
- **Speculative Plans**: Enabled

### Security Notes

- The API token is marked as sensitive and should never be committed to version control
- Use environment variables or secure variable management for the API token
- Ensure proper IAM permissions in your Terraform Cloud organization

## Outputs

After successful deployment, you'll get:
- Workspace ID
- Workspace name
- Workspace URL
- Organization name
- Project name
