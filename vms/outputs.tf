# ==> Multi-Region Infrastructure Outputs <==

# ==> VPC Outputs <==
output "vpc_ids" {
  description = "IDs of the VPCs created in each region"
  value = merge(
    contains(var.aws_regions, "us-east-1") ? { "us-east-1" = module.us_east_1[0].vpc_id } : {},
    contains(var.aws_regions, "eu-central-1") ? { "eu-central-1" = module.eu_central_1[0].vpc_id } : {},
    contains(var.aws_regions, "eu-west-1") ? { "eu-west-1" = module.eu_west_1[0].vpc_id } : {}
  )
}

# ==> Subnet Outputs <==
output "public_subnet_ids" {
  description = "IDs of the public subnets in each region"
  value = merge(
    contains(var.aws_regions, "us-east-1") ? { "us-east-1" = module.us_east_1[0].subnet_id } : {},
    contains(var.aws_regions, "eu-central-1") ? { "eu-central-1" = module.eu_central_1[0].subnet_id } : {},
    contains(var.aws_regions, "eu-west-1") ? { "eu-west-1" = module.eu_west_1[0].subnet_id } : {}
  )
}

# ==> Security Group Outputs <==
output "security_group_ids" {
  description = "IDs of the security groups in each region"
  value = merge(
    contains(var.aws_regions, "us-east-1") ? { "us-east-1" = module.us_east_1[0].security_group_id } : {},
    contains(var.aws_regions, "eu-central-1") ? { "eu-central-1" = module.eu_central_1[0].security_group_id } : {},
    contains(var.aws_regions, "eu-west-1") ? { "eu-west-1" = module.eu_west_1[0].security_group_id } : {}
  )
}

# ==> Key Pair Outputs <==
output "key_pair_names" {
  description = "Names of the key pairs in each region"
  value = merge(
    contains(var.aws_regions, "us-east-1") ? { "us-east-1" = module.us_east_1[0].key_pair_name } : {},
    contains(var.aws_regions, "eu-central-1") ? { "eu-central-1" = module.eu_central_1[0].key_pair_name } : {},
    contains(var.aws_regions, "eu-west-1") ? { "eu-west-1" = module.eu_west_1[0].key_pair_name } : {}
  )
}

# ==> Summary Output <==
output "deployment_summary" {
  description = "Summary of the multi-region deployment"
  value = {
    regions_deployed         = var.aws_regions
    instance_region         = "eu-central-1"
    total_vpcs              = length(var.aws_regions)
    total_instances         = 1
    instance_type           = var.instance_type
  }
}