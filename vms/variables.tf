variable "aws_regions" {
  description = "List of AWS regions to create resources in."
  type        = list(string)
  default     = ["us-east-1", "eu-central-1", "eu-west-1"]
}

variable "instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t2.micro" # Or t3.micro, t4g.micro (ARM) depending on availability and cost
}

variable "ami_ids" {
  description = "AMI IDs for Fedora in each region."
  type        = map(string)
  default = {
    "us-east-1"    = "ami-06dd92742425a21ec"  # Update with actual Fedora AMI for us-east-1
    "eu-central-1" = "ami-0abcdef1234567890"  # Update with actual Fedora AMI for eu-central-1
    "eu-west-1"    = "ami-0fedcba0987654321"  # Update with actual Fedora AMI for eu-west-1
  }
}

variable "user_public_key" {
  description = "SSH public key string."
  type        = string
}

variable "key_pair_name" {
  description = "Name of the SSH key pair to create or use."
  type        = string
  default     = "fedora-vm-tf-key" # Change this to your preferred key pair name
}

variable "aws_access_key" {
  description = "AWS Access Key ID."
  type        = string
  sensitive   = true # Marks the variable as sensitive in Terraform output
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key."
  type        = string
  sensitive   = true # Marks the variable as sensitive in Terraform output
}

variable "vpc_cidr_blocks" {
  description = "CIDR blocks for VPCs in each region."
  type        = map(string)
  default = {
    "us-east-1"    = "10.0.0.0/16"
    "eu-central-1" = "10.1.0.0/16"
    "eu-west-1"    = "10.2.0.0/16"
  }
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for subnets in each region."
  type        = map(string)
  default = {
    "us-east-1"    = "10.0.1.0/24"
    "eu-central-1" = "10.1.1.0/24"
    "eu-west-1"    = "10.2.1.0/24"
  }
}