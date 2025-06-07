variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be launched"
  type        = string
  default     = ""
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the instance"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Additional tags to apply to the instance"
  type        = map(string)
  default = {
    Environment = "Development"
  }
}