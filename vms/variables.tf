variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1" # Change this to your preferred region
}

variable "instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t2.micro" # Or t3.micro, t4g.micro (ARM) depending on availability and cost
}

variable "ami_id" {
  description = "The AMI ID for Fedora 42. Update this when available."
  type        = string
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

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability Zone for the subnet (e.g., us-east-1a). Leave empty to let AWS choose."
  type        = string
  default     = "" # e.g., "us-east-1a". If empty, AWS picks one in the region.
                   # It's better to specify one if you know it, or use data source to pick one.
}