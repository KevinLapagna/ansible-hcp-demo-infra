# ==> Multi-Region Infrastructure Outputs <==

# ==> VPC Outputs <==
output "vpc_ids" {
  description = "IDs of the VPCs created in each region"
  value = {
    "us-east-1"    = aws_vpc.main_us_east_1.id
    "eu-central-1" = aws_vpc.main_eu_central_1.id
    "eu-west-1"    = aws_vpc.main_eu_west_1.id
  }
}

output "vpc_cidr_blocks" {
  description = "CIDR blocks of the VPCs in each region"
  value = {
    "us-east-1"    = aws_vpc.main_us_east_1.cidr_block
    "eu-central-1" = aws_vpc.main_eu_central_1.cidr_block
    "eu-west-1"    = aws_vpc.main_eu_west_1.cidr_block
  }
}

# ==> Subnet Outputs <==
output "public_subnet_ids" {
  description = "IDs of the public subnets in each region"
  value = {
    "us-east-1"    = aws_subnet.public_us_east_1.id
    "eu-central-1" = aws_subnet.public_eu_central_1.id
    "eu-west-1"    = aws_subnet.public_eu_west_1.id
  }
}

output "availability_zones" {
  description = "Availability zones used in each region"
  value = {
    "us-east-1"    = aws_subnet.public_us_east_1.availability_zone
    "eu-central-1" = aws_subnet.public_eu_central_1.availability_zone
    "eu-west-1"    = aws_subnet.public_eu_west_1.availability_zone
  }
}

# ==> Security Group Outputs <==
output "security_group_ids" {
  description = "IDs of the security groups in each region"
  value = {
    "us-east-1"    = aws_security_group.allow_ssh_us_east_1.id
    "eu-central-1" = aws_security_group.allow_ssh_eu_central_1.id
    "eu-west-1"    = aws_security_group.allow_ssh_eu_west_1.id
  }
}

# ==> Key Pair Outputs <==
output "key_pair_names" {
  description = "Names of the key pairs in each region"
  value = {
    "us-east-1"    = aws_key_pair.vm_auth_us_east_1.key_name
    "eu-central-1" = aws_key_pair.vm_auth_eu_central_1.key_name
    "eu-west-1"    = aws_key_pair.vm_auth_eu_west_1.key_name
  }
}

# ==> Instance Outputs <==
output "instance_ids" {
  description = "IDs of the EC2 instances in each region"
  value = {
    "us-east-1"    = aws_instance.native_lion_vm_us_east_1.id
    "eu-central-1" = aws_instance.native_lion_vm_eu_central_1.id
    "eu-west-1"    = aws_instance.native_lion_vm_eu_west_1.id
  }
}

output "instance_public_ips" {
  description = "Public IP addresses of the EC2 instances in each region"
  value = {
    "us-east-1"    = aws_instance.native_lion_vm_us_east_1.public_ip
    "eu-central-1" = aws_instance.native_lion_vm_eu_central_1.public_ip
    "eu-west-1"    = aws_instance.native_lion_vm_eu_west_1.public_ip
  }
}

output "instance_private_ips" {
  description = "Private IP addresses of the EC2 instances in each region"
  value = {
    "us-east-1"    = aws_instance.native_lion_vm_us_east_1.private_ip
    "eu-central-1" = aws_instance.native_lion_vm_eu_central_1.private_ip
    "eu-west-1"    = aws_instance.native_lion_vm_eu_west_1.private_ip
  }
}

output "instance_public_dns" {
  description = "Public DNS names of the EC2 instances in each region"
  value = {
    "us-east-1"    = aws_instance.native_lion_vm_us_east_1.public_dns
    "eu-central-1" = aws_instance.native_lion_vm_eu_central_1.public_dns
    "eu-west-1"    = aws_instance.native_lion_vm_eu_west_1.public_dns
  }
}

# ==> SSH Connection Information <==
output "ssh_connection_commands" {
  description = "SSH commands to connect to instances in each region"
  value = {
    "us-east-1"    = "ssh -i ~/.ssh/${var.key_pair_name} fedora@${aws_instance.native_lion_vm_us_east_1.public_ip}"
    "eu-central-1" = "ssh -i ~/.ssh/${var.key_pair_name} fedora@${aws_instance.native_lion_vm_eu_central_1.public_ip}"
    "eu-west-1"    = "ssh -i ~/.ssh/${var.key_pair_name} fedora@${aws_instance.native_lion_vm_eu_west_1.public_ip}"
  }
}

# ==> Summary Output <==
output "deployment_summary" {
  description = "Summary of the multi-region deployment"
  value = {
    regions_deployed = var.aws_regions
    total_instances  = length(var.aws_regions)
    vpc_count       = length(var.aws_regions)
    instance_type   = var.instance_type
  }
}