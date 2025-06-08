# Ansible HCP Demo Infrastructure

Infrastructure as Code for Ansible HashiCorp Cloud Platform demonstration environment using Terraform and AWS.

## Project Structure

- **`bootstrap/`** - Initial setup for variable sets and secrets management
- **`workspaces/`** - HCP workspace management configuration
- **`vms/`** - AWS EC2 instances for Ansible demonstrations

## Quick Start

1. **Bootstrap**: Set up variable sets and secrets in Terraform Cloud
2. **Workspaces**: Create HCP workspace for infrastructure management
3. **VMs**: Deploy AWS infrastructure via HCP workspace

## Architecture

- **Organization**: lennart-org
- **Project**: RH_HCP
- **Workspace**: `ansible-hcp-demo-ec2-vms` (manages AWS VMs)

## Prerequisites

- Terraform Cloud account with API token
- AWS credentials
- GitHub repository with App integration

## Security

Sensitive values are managed via:
- Terraform Cloud variable sets
- Template files (actual secrets excluded from git)
- GitHub App integration for secure VCS access

## Workflow

1. Run bootstrap locally to create variable sets
2. Apply workspace configuration to create HCP workspace
3. HCP workspace automatically manages VM infrastructure via VCS triggers