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
# BEGIN ANSIBLE MANAGED BLOCK - alert_fox

# alert fox VM Instance - Added by Ansible
module "alert_fox_vm" {
  source = "./modules/ec2-instance"

  # Required parameters
  instance_name = "alert-fox-VM"
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
# END ANSIBLE MANAGED BLOCK - alert_fox
# BEGIN ANSIBLE MANAGED BLOCK - modern_bee

# modern bee VM Instance - Added by Ansible
module "modern_bee_vm" {
  source = "./modules/ec2-instance"

  # Required parameters
  instance_name = "modern-bee-VM"
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
# END ANSIBLE MANAGED BLOCK - modern_bee
# BEGIN ANSIBLE MANAGED BLOCK - social_elf

# social elf VM Instance - Added by Ansible
module "social_elf_vm" {
  source = "./modules/ec2-instance"

  # Required parameters
  instance_name = "social-elf-VM"
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
# END ANSIBLE MANAGED BLOCK - social_elf
# BEGIN ANSIBLE MANAGED BLOCK - kind_magpie

# kind magpie VM Instance - Added by Ansible
module "kind_magpie_vm" {
  source = "./modules/ec2-instance"

  # Required parameters
  instance_name = "kind-magpie-VM"
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
# END ANSIBLE MANAGED BLOCK - kind_magpie
# BEGIN ANSIBLE MANAGED BLOCK - heroic_crane

# heroic crane VM Instance - Added by Ansible
module "heroic_crane_vm" {
  source = "./modules/ec2-instance"

  # Required parameters
  instance_name = "heroic-crane-VM"
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
# END ANSIBLE MANAGED BLOCK - heroic_crane
# BEGIN ANSIBLE MANAGED BLOCK - smooth_dory

# smooth dory VM Instance - Added by Ansible
module "smooth_dory_vm" {
  source = "./modules/ec2-instance"

  # Required parameters
  instance_name = "smooth-dory-VM"
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
# END ANSIBLE MANAGED BLOCK - smooth_dory
