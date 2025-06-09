# ==> EC2 Instances <==
# This file contains all EC2 instance definitions using a local module pattern
# Add new instances by copying the fedora_vm module block below

# Fedora VM Instance - using defaults from root module
module "fedora_vm" {
  source = "./modules/ec2-instance"
  
  # Required parameters
  instance_name = "Fedora42-VM"
  instance_type = var.instance_type
  
  # Default parameters (can be overridden as needed)
  ami_id             = var.ami_id
  key_name           = aws_key_pair.vm_auth.key_name
  subnet_id          = aws_subnet.public.id
  security_group_ids = [aws_security_group.allow_ssh.id]
  # tags = {
  #   Environment = "Production"  # Override default "Development"
  #   CustomTag   = "Example"
  # }
}

# Example: Add more instances with minimal configuration
# module "web_server_vm" {
#   source = "./modules/ec2-instance"
#   
#   instance_name = "WebServer-VM"
#   instance_type = "t3.small"
#   
#   # Uses same defaults as above, but you can override as needed:
#   ami_id             = var.ami_id                         # Same AMI
#   key_name           = aws_key_pair.vm_auth.key_name      # Same key pair
#   subnet_id          = aws_subnet.public.id               # Same subnet
#   security_group_ids = [aws_security_group.allow_ssh.id]  # Same security group
#   # tags = {
#   #   Environment = "Production"  # Override default "Development"
#   #   Role        = "WebServer"
#   # }
# }
# BEGIN ANSIBLE MANAGED BLOCK - loyal_midge

# Loyal midge VM Instance - Added by Ansible
module "loyal_midge_vm" {
  source = "./modules/ec2-instance"
  
  # Required parameters
  instance_name = "Loyal-midge-VM"
  instance_type = var.instance_type
  
  # Default parameters (can be overridden as needed)
  ami_id             = var.ami_id
  key_name           = aws_key_pair.vm_auth.key_name
  subnet_id          = aws_subnet.public.id
  security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Environment = "Development"
    CreatedBy   = "Ansible"
    RandomName  = "loyal_midge"
  }
}
# END ANSIBLE MANAGED BLOCK - loyal_midge
# BEGIN ANSIBLE MANAGED BLOCK - next_squid

# next squid VM Instance - Added by Ansible
module "next_squid_vm" {
  source = "./modules/ec2-instance"

  # Required parameters
  instance_name = "next-squid-VM"
  instance_type = var.instance_type

  # Default parameters (can be overridden as needed)
  ami_id             = var.ami_id
  key_name           = aws_key_pair.vm_auth.key_name
  subnet_id          = aws_subnet.public.id
  security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Environment = "Development"
    CreatedBy   = "Ansible"
  }
}
# END ANSIBLE MANAGED BLOCK - next_squid
# BEGIN ANSIBLE MANAGED BLOCK - main_husky

# main husky VM Instance - Added by Ansible
module "main_husky_vm" {
  source = "./modules/ec2-instance"

  # Required parameters
  instance_name = "main-husky-VM"
  instance_type = var.instance_type

  # Default parameters (can be overridden as needed)
  ami_id             = var.ami_id
  key_name           = aws_key_pair.vm_auth.key_name
  subnet_id          = aws_subnet.public.id
  security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Environment = "Development"
    CreatedBy   = "Ansible"
  }
}
# END ANSIBLE MANAGED BLOCK - main_husky
# BEGIN ANSIBLE MANAGED BLOCK - mutual_serval

# mutual serval VM Instance - Added by Ansible
module "mutual_serval_vm" {
  source = "./modules/ec2-instance"

  # Required parameters
  instance_name = "mutual-serval-VM"
  instance_type = var.instance_type

  # Default parameters (can be overridden as needed)
  ami_id             = var.ami_id
  key_name           = aws_key_pair.vm_auth.key_name
  subnet_id          = aws_subnet.public.id
  security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Environment = "Development"
    CreatedBy   = "Ansible"
  }
}
# END ANSIBLE MANAGED BLOCK - mutual_serval
