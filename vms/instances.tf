# ==> EC2 Instance - Only in eu-central-1 <==
resource "aws_instance" "native_lion_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a98b5f222a0d2396"
  instance_type = var.instance_type
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id
  
  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "native-lion-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "Terraform"
    Region      = "eu-central-1"
  }
}
# BEGIN ANSIBLE MANAGED BLOCK - amazed_turtle
# amazed turtle VM Instance - Added by Ansible
resource "aws_instance" "amazed_turtle_vm" {
  ami           = "Fedora CoreOS 42"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.vm_auth.key_name
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name        = "amazed-turtle-VM"
    Environment = "Development"
    CreatedBy   = "Ansible"
  }
}
# END ANSIBLE MANAGED BLOCK - amazed_turtle
