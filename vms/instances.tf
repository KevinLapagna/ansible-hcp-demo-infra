# ==> EC2 Instances <==
# This file contains all EC2 instance definitions using a local module pattern
#
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
