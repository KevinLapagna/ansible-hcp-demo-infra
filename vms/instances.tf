# ==> EC2 Instances <==
# This file contains all EC2 instance definitions using aws_instance resources
#
# Multi-region VM deployment with explicit resources per region for easy management

# ==> Native Lion VM Instances <==
resource "aws_instance" "native_lion_vm_us_east_1" {
  provider = aws.us_east_1
  
  ami           = var.ami_ids["us-east-1"]
  instance_type = var.instance_type
  key_name      = aws_key_pair.vm_auth_us_east_1.key_name
  subnet_id     = aws_subnet.public_us_east_1.id
  
  vpc_security_group_ids = [aws_security_group.allow_ssh_us_east_1.id]

  tags = {
    Name        = "native-lion-VM-us-east-1"
    Environment = "Development"
    CreatedBy   = "Terraform"
    Region      = "us-east-1"
  }
}

resource "aws_instance" "native_lion_vm_eu_central_1" {
  provider = aws.eu_central_1
  
  ami           = var.ami_ids["eu-central-1"]
  instance_type = var.instance_type
  key_name      = aws_key_pair.vm_auth_eu_central_1.key_name
  subnet_id     = aws_subnet.public_eu_central_1.id
  
  vpc_security_group_ids = [aws_security_group.allow_ssh_eu_central_1.id]

  tags = {
    Name        = "native-lion-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "Terraform"
    Region      = "eu-central-1"
  }
}

resource "aws_instance" "native_lion_vm_eu_west_1" {
  provider = aws.eu_west_1
  
  ami           = var.ami_ids["eu-west-1"]
  instance_type = var.instance_type
  key_name      = aws_key_pair.vm_auth_eu_west_1.key_name
  subnet_id     = aws_subnet.public_eu_west_1.id
  
  vpc_security_group_ids = [aws_security_group.allow_ssh_eu_west_1.id]

  tags = {
    Name        = "native-lion-VM-eu-west-1"
    Environment = "Development"
    CreatedBy   = "Terraform"
    Region      = "eu-west-1"
  }
}
