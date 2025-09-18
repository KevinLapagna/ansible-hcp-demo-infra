# VMs Module

This module provisions EC2 instances for the Ansible HCP demo infrastructure.

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## Variables

Configure required variables in `terraform.tfvars`:
- `aws_access_key` - AWS access key
- `aws_secret_key` - AWS secret key
- `ami_ids` - AMI IDs per region
- `instance_type` - EC2 instance type

## Outputs

- Instance public IP and DNS name
- Key pair names and security group IDs per region