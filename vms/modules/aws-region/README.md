# AWS Region Module

This module creates a complete AWS infrastructure setup for a single region, including:

- VPC with DNS support
- Internet Gateway
- Public Subnet
- Route Table and associations
- Security Group (allowing SSH access)
- SSH Key Pair
- EC2 Instance

## Usage

```hcl
module "us_east_1" {
  source = "./modules/aws-region"

  region             = "us-east-1"
  aws_access_key     = var.aws_access_key
  aws_secret_key     = var.aws_secret_key
  vpc_cidr_block     = "10.0.0.0/16"
  subnet_cidr_block  = "10.0.1.0/24"
  instance_type      = "t2.micro"
  ami_id             = "ami-06dd92742425a21ec"
  user_public_key    = var.user_public_key
  key_pair_name      = "my-key-pair"
}
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| region | AWS region | `string` | yes |
| aws_access_key | AWS Access Key ID | `string` | yes |
| aws_secret_key | AWS Secret Access Key | `string` | yes |
| vpc_cidr_block | CIDR block for VPC | `string` | yes |
| subnet_cidr_block | CIDR block for subnet | `string` | yes |
| instance_type | EC2 instance type | `string` | yes |
| ami_id | AMI ID for the region | `string` | yes |
| user_public_key | SSH public key string | `string` | yes |
| key_pair_name | Name of the SSH key pair | `string` | yes |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the VPC |
| subnet_id | ID of the public subnet |
| security_group_id | ID of the security group |
| internet_gateway_id | ID of the internet gateway |
| key_pair_name | Name of the key pair |
| instance_id | ID of the EC2 instance |
| instance_public_ip | Public IP address of the EC2 instance |
| instance_public_dns | Public DNS name of the EC2 instance |

## Security Considerations

⚠️ **Warning**: The default security group allows SSH access from any IP address (0.0.0.0/0). For production use, restrict this to specific IP ranges or implement bastion host access patterns.

## Resources Created

- `aws_vpc` - Virtual Private Cloud
- `aws_internet_gateway` - Internet Gateway
- `aws_subnet` - Public Subnet
- `aws_route_table` - Route Table for public subnet
- `aws_route_table_association` - Route Table Association
- `aws_security_group` - Security Group for SSH access
- `aws_key_pair` - SSH Key Pair
- `aws_instance` - EC2 Instance (Fedora)
