# Workspace Management

Terraform configuration for managing HCP workspaces. This configuration creates and manages workspaces that handle infrastructure deployment.

## Workspaces Created

- **`ansible-hcp-demo-ec2-vms`** - Manages AWS VMs (working directory: `vms/`)

## Management

The `workspace-management` workspace runs this configuration to manage other workspaces. Changes to this directory trigger automatic runs in the workspace-management workspace.

## Configuration

- **Organization**: lennart-org
- **Project**: RH_HCP
- **VCS Integration**: GitHub App with repository auto-triggers
- **Variable Sets**: Automatically assigned AWS and TFE credentials

## Setup

1. **Initial run**: Apply locally to create both workspaces
2. **Import existing**: If workspace-management exists, import it first
3. **Transition**: After creation, workspace-management manages itself

## Security

- TFE credentials managed via variable sets
- Sensitive values excluded from VCS
- Auto-apply disabled for safety on workspace-management