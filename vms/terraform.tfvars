# Multi-Region VM Configuration

# Regions to deploy to (you can add or remove regions as needed)
aws_regions = ["us-east-1", "eu-central-1", "eu-west-1"]

# Instance Configuration
instance_type = "t2.micro"

# SSH Configuration
user_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKjk0BAqV14r7Bb+GRF26yFVKOgeAIgXjkgflULIdiTQ ansible@aap"
key_pair_name   = "aap-ssh-key"  # Name of the SSH key pair to be created



# Network Configuration (Optional - defaults are provided in variables.tf)
# Uncomment and modify if you want to override the default CIDR blocks

# vpc_cidr_blocks = {
#   "us-east-1"    = "10.0.0.0/16"
#   "eu-central-1" = "10.1.0.0/16"
#   "eu-west-1"    = "10.2.0.0/16"
# }

# subnet_cidr_blocks = {
#   "us-east-1"    = "10.0.1.0/24"
#   "eu-central-1" = "10.1.1.0/24"
#   "eu-west-1"    = "10.2.1.0/24"
# }