# Bootstrap Configuration

Initial setup for variable sets and secrets management in Terraform Cloud.

## Purpose

Creates organization-level variable sets containing:
- **TFE credentials** (hostname, API token)
- **AWS credentials** (access key, secret key)

## Usage

1. **Setup secrets**:
   ```bash
   cp secrets.auto.tfvars.template secrets.auto.tfvars
   # Edit secrets.auto.tfvars with your actual credentials
   ```

2. **Apply configuration**:
   ```bash
   terraform init
   terraform apply
   ```

## Variable Sets Created

- **`tfe-credentials`** - Applied to workspace-management workspace
- **`aws-credentials`** - Applied to ansible-hcp-demo-ec2-vms workspace

## Security

- Use template file for credential setup
- Never commit actual `secrets.auto.tfvars` to version control
- All credentials marked as sensitive in Terraform Cloud