# VM Infrastructure

AWS EC2 infrastructure for Ansible demonstrations using modular Terraform configuration.

## Components

- **VPC** with public subnet and internet gateway
- **Fedora 42 EC2 instance** for Ansible target
- **Security groups** allowing SSH access
- **SSH key pair** for instance access

## Structure

- `main.tf` - Core networking infrastructure
- `instances.tf` - EC2 instance definitions
- `modules/ec2-instance/` - Reusable EC2 module

## Usage

This configuration runs in the `ansible-hcp-demo-02` HCP workspace:

1. **Configure variables** in HCP workspace UI
2. **Push changes** to trigger automatic runs
3. **Manual runs** can be triggered from HCP UI

## Outputs

- `instance_public_ip` - Public IP of Fedora instance
- `instance_id` - AWS instance identifier
- SSH access via configured key pair

## Prerequisites

- AWS credentials configured in HCP workspace (via variable sets)
- Terraform Cloud workspace with VCS integration
- Valid AMI ID for Fedora 42 in target region