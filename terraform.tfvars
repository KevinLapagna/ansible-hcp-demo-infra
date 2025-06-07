# Other variables
aws_region             = "eu-north-1" # Change this to your preferred AWS region
instance_type          = "t2.micro"
ami_id                 = "ami-03318173cd159e1eb" # Fedora Core 42 (x86_64) - Update this when available
user_public_key        = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEd9LF2GQWbP6mrLlk8cDYio/NrHeSSp0+OH6rUWYhtJ kev@pyxis"
key_pair_name          = "fedora-vm-tf-key"

# Network Configuration (defaults are likely fine, but you can override)
vpc_cidr_block         = "10.0.0.0/16"
subnet_cidr_block      = "10.0.1.0/24"
availability_zone      = "eu-north-1a" # Set a specific AZ for your region. Or leave empty/comment out to let AWS pick.