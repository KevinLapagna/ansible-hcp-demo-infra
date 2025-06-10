# ==> EC2 Instances <==
# This file contains all EC2 instance definitions using aws_instance resources
#
# Example: Add more instances with minimal configuration
# resource "aws_instance" "web_server_vm" {
#   ami           = var.ami_id
#   instance_type = "t3.small"
#   key_name      = aws_key_pair.vm_auth.key_name
#   subnet_id     = aws_subnet.public.id
#   
#   vpc_security_group_ids = [aws_security_group.allow_ssh.id]
#   
#   tags = {
#     Name        = "WebServer-VM"
#     Environment = "Production"
#     Role        = "WebServer"
#   }
# }
