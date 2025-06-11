# Multi-Region VM Infrastructure

AWS EC2 infrastructure for Ansible demonstrations using multi-region Terraform configuration with loops and lists for easy scalability.

## Features

- **Multi-Region Deployment**: Supports us-east-1, eu-central-1, and eu-west-1 regions
- **Scalable Architecture**: Uses for_each loops and lists to easily add more regions
- **Isolated Networks**: Separate VPC, subnets, and security groups per region
- **Consistent Configuration**: Same infrastructure deployed across all regions
- **Region-Specific Resources**: Key pairs, AMIs, and availability zones per region

## Components Per Region

- **VPC** with dedicated CIDR block and DNS support
- **Public Subnet** with auto-assigned public IPs
- **Internet Gateway** and routing table for internet access
- **Security Group** allowing SSH access (port 22)
- **EC2 Key Pair** for SSH authentication
- **Fedora EC2 Instance** for Ansible target

## Architecture

```
Region: us-east-1 (10.0.0.0/16)
├── VPC: fedora-vm-vpc-us-east-1
├── Subnet: fedora-vm-public-subnet-us-east-1 (10.0.1.0/24)
├── Instance: native-lion-VM-us-east-1
└── Key Pair: <key_pair_name>-us-east-1

Region: eu-central-1 (10.1.0.0/16)
├── VPC: fedora-vm-vpc-eu-central-1
├── Subnet: fedora-vm-public-subnet-eu-central-1 (10.1.1.0/24)
├── Instance: native-lion-VM-eu-central-1
└── Key Pair: <key_pair_name>-eu-central-1

Region: eu-west-1 (10.2.0.0/16)
├── VPC: fedora-vm-vpc-eu-west-1
├── Subnet: fedora-vm-public-subnet-eu-west-1 (10.2.1.0/24)
├── Instance: native-lion-VM-eu-west-1
└── Key Pair: <key_pair_name>-eu-west-1
```

## File Structure

- `main.tf` - Multi-region networking infrastructure and providers
- `instances.tf` - EC2 instance definitions with regional deployment
- `variables.tf` - Variable definitions supporting multi-region configuration
- `outputs.tf` - Comprehensive outputs for all regions and resources
- `terraform.tfvars` - Variable values (create from template)

## Configuration

### Required Variables

```terraform
# AWS Credentials
aws_access_key = "your-access-key"
aws_secret_key = "your-secret-key"

# SSH Configuration
user_public_key = "ssh-rsa AAAAB3NzaC1yc2E... your-public-key"
key_pair_name = "my-terraform-key"

# Instance Configuration
instance_type = "t2.micro"

# AMI IDs per region (update with actual Fedora AMI IDs)
ami_ids = {
  "us-east-1"    = "ami-06dd92742425a21ec"
  "eu-central-1" = "ami-0abcdef1234567890"
  "eu-west-1"    = "ami-0fedcba0987654321"
}
```

### Optional Variables (with defaults)

```terraform
# Regions to deploy to
aws_regions = ["us-east-1", "eu-central-1", "eu-west-1"]

# Network Configuration (per region)
vpc_cidr_blocks = {
  "us-east-1"    = "10.0.0.0/16"
  "eu-central-1" = "10.1.0.0/16"
  "eu-west-1"    = "10.2.0.0/16"
}

subnet_cidr_blocks = {
  "us-east-1"    = "10.0.1.0/24"
  "eu-central-1" = "10.1.1.0/24"
  "eu-west-1"    = "10.2.1.0/24"
}
```

## Usage

### Initial Setup

1. **Copy terraform.tfvars template**:
   ```bash
   cp terraform.tfvars.template terraform.tfvars
   ```

2. **Edit terraform.tfvars** with your values:
   - AWS credentials
   - SSH public key
   - Region-specific AMI IDs

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

### Deployment

4. **Plan deployment**:
   ```bash
   terraform plan
   ```

5. **Apply configuration**:
   ```bash
   terraform apply
   ```

### Adding New Regions

To add new regions (e.g., ap-southeast-1):

1. **Update variables.tf** (or override in terraform.tfvars):
   ```terraform
   aws_regions = ["us-east-1", "eu-central-1", "eu-west-1", "ap-southeast-1"]
   
   vpc_cidr_blocks = {
     # ...existing regions...
     "ap-southeast-1" = "10.3.0.0/16"
   }
   
   subnet_cidr_blocks = {
     # ...existing regions...
     "ap-southeast-1" = "10.3.1.0/24"
   }
   
   ami_ids = {
     # ...existing regions...
     "ap-southeast-1" = "ami-newregionami123"
   }
   ```

2. **Add provider** in main.tf:
   ```terraform
   provider "aws" {
     alias      = "ap_southeast_1"
     region     = "ap-southeast-1"
     access_key = var.aws_access_key
     secret_key = var.aws_secret_key
   }
   ```

3. **Update provider conditionals** in main.tf and instances.tf to include the new region

## Outputs

The configuration provides comprehensive outputs for all regions:

- **Infrastructure IDs**: VPC, subnet, security group IDs per region
- **Instance Information**: Instance IDs, public/private IPs, DNS names per region
- **SSH Commands**: Ready-to-use SSH connection commands per region
- **Deployment Summary**: Overview of deployed resources

### Example Output Usage

```bash
# Get all public IPs
terraform output instance_public_ips

# Get SSH commands for all regions
terraform output ssh_connection_commands

# Get deployment summary
terraform output deployment_summary
```

## SSH Access

After deployment, connect to instances using:

```bash
# us-east-1
ssh -i ~/.ssh/your-private-key fedora@<us-east-1-public-ip>

# eu-central-1
ssh -i ~/.ssh/your-private-key fedora@<eu-central-1-public-ip>

# eu-west-1
ssh -i ~/.ssh/your-private-key fedora@<eu-west-1-public-ip>
```

## Security Considerations

- **SSH Access**: Currently allows SSH from any IP (0.0.0.0/0). Restrict to your IP range for production.
- **Key Management**: Each region has its own key pair with region suffix.
- **Network Isolation**: Each region has completely isolated networking.

## Cleanup

To destroy all resources across all regions:

```bash
terraform destroy
```

## Prerequisites

- AWS credentials with appropriate permissions
- SSH key pair generated locally
- Terraform >= 1.0
- Valid Fedora AMI IDs for target regions