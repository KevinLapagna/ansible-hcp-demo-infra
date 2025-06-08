# Ansible HCP Demo Infrastructure

Infrastructure as Code for Ansible HashiCorp Cloud Platform demonstration environment using Terraform and AWS.

## Project Structure

- **`bootstrap/`** - Initial setup for variable sets and secrets management
- **`workspaces/`** - HCP workspace management (manages itself via workspace-management)
- **`vms/`** - AWS EC2 instances for Ansible demonstrations

## Quick Start

1. **Bootstrap**: Set up variable sets and secrets
2. **Workspaces**: Create HCP workspaces for infrastructure management
3. **VMs**: Deploy AWS infrastructure for Ansible demos

## Architecture

- **Organization**: lennart-org
- **Project**: RH_HCP
- **Workspaces**: 
  - `workspace-management` (manages HCP workspaces)
  - `ansible-hcp-demo-02` (manages AWS VMs)

## Prerequisites

- Terraform Cloud account with API token
- AWS credentials
- GitHub repository with VCS integration

## Security

Sensitive values are managed via:
- Terraform Cloud variable sets
- Environment variables
- Template files (actual secrets excluded from git)

## Usage

Each directory contains its own README with specific setup instructions.