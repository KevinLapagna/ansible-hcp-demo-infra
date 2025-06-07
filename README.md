# Ansible HCP Demo Infrastructure

This repository contains Terraform infrastructure as code (IaC) for provisioning AWS resources to support an Ansible HashiCorp Cloud Platform (HCP) demonstration environment.

## Overview

This project creates a simple AWS infrastructure consisting of:
- A VPC with public subnet
- A Fedora 42 EC2 instance for Ansible demonstrations
- Basic networking components (Internet Gateway, Route Tables, Security Groups)
- SSH key pair management

## Infrastructure Components

### Core Infrastructure (`main.tf`)
- **VPC**: Custom Virtual Private Cloud with DNS support
- **Internet Gateway**: Provides internet access to public resources
- **Public Subnet**: Subnet with auto-assigned public IPs
- **Route Table**: Routes traffic to the internet gateway
- **Security Group**: Allows SSH access (port 22) from anywhere
- **Key Pair**: SSH key pair for instance access

### EC2 Instances (`instances.tf`)
- **Fedora VM**: A single Fedora 42 instance configured through a reusable module
- Uses the modular approach for easy scaling and management

### Modules (`modules/ec2-instance/`)
A reusable EC2 instance module that standardizes instance deployment with:
- Configurable instance type, AMI, and networking
- Customizable tags and naming
- Security group assignment

## Configuration

### Required Variables (`variables.tf`)
- `aws_region`: AWS region for resource deployment (default: us-east-1)
- `ami_id`: AMI ID for Fedora 42 (must be specified)
- `user_public_key`: SSH public key for instance access
- `aws_access_key`: AWS Access Key ID
- `aws_secret_key`: AWS Secret Access Key

### Optional Variables
- `instance_type`: EC2 instance type (default: t2.micro)
- `key_pair_name`: Name for the SSH key pair (default: fedora-vm-tf-key)
- Network CIDR blocks for VPC and subnet configuration

## Usage

1. **Configure variables**: Update `terraform.tfvars` with your specific values
2. **Initialize Terraform**: `terraform init`
3. **Plan deployment**: `terraform plan`
4. **Apply changes**: `terraform apply`

## Outputs

The configuration provides the following outputs:
- `instance_public_ip`: Public IP address of the Fedora instance
- `instance_id`: AWS instance identifier

## Remote State Management

This project is configured to use Terraform Cloud for remote state management with the organization "lennart-org" and workspace "kev-workspace-01".

## Purpose

This infrastructure serves as a foundation for Ansible demonstrations and testing, providing a clean, reproducible environment for showcasing Ansible automation capabilities with HashiCorp Cloud Platform integration.
