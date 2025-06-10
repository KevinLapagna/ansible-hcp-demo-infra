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

# BEGIN ANSIBLE MANAGED BLOCK - united_doe
# united doe VM Instance - Added by Ansible
resource "aws_instance" "united_doe_vm" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.vm_auth.key_name
  subnet_id     = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name        = "united-doe-VM"
    Environment = "Development"
    CreatedBy   = "Ansible"
  }
}
# END ANSIBLE MANAGED BLOCK - united_doe

# BEGIN ANSIBLE MANAGED BLOCK - proud_llama
# proud llama VM Instance - Added by Ansible
resource "aws_instance" "proud_llama_vm" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.vm_auth.key_name
  subnet_id     = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name        = "proud-llama-VM"
    Environment = "Development"
    CreatedBy   = "Ansible"
  }
}
# END ANSIBLE MANAGED BLOCK - proud_llama

# BEGIN ANSIBLE MANAGED BLOCK - tender_filly
# tender filly VM Instance - Added by Ansible
resource "aws_instance" "tender_filly_vm" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.vm_auth.key_name
  subnet_id     = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name        = "tender-filly-VM"
    Environment = "Development"
    CreatedBy   = "Ansible"
  }
}
# END ANSIBLE MANAGED BLOCK - tender_filly
# BEGIN ANSIBLE MANAGED BLOCK - boss_tiger
# boss tiger VM Instance - Added by Ansible
resource "aws_instance" "boss_tiger_vm" {
  ami           = "ami-0fe630eb857a6ec83"
  instance_type = var.instance_type
  key_name      = aws_key_pair.vm_auth.key_name
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name        = "boss-tiger-VM"
    Environment = "Development"
    CreatedBy   = "Ansible"
  }
}
# END ANSIBLE MANAGED BLOCK - boss_tiger
# BEGIN ANSIBLE MANAGED BLOCK - 
#  VM Instance - Added by Ansible
resource "aws_instance" "_vm" {
  ami           = "ami-02d7e5b6f3a6a1a14"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.vm_auth.key_name
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name        = "-VM"
    Environment = "Development"
    CreatedBy   = "Ansible"
  }
}
# END ANSIBLE MANAGED BLOCK - 
# BEGIN ANSIBLE MANAGED BLOCK - simple_orca
# simple orca VM Instance - Added by Ansible
resource "aws_instance" "simple_orca_vm" {
  ami           = "ami-02d7e5b6f3a6a1a14"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.vm_auth.key_name
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name        = "simple-orca-VM"
    Environment = "Development"
    CreatedBy   = "Ansible"
  }
}
# END ANSIBLE MANAGED BLOCK - simple_orca
