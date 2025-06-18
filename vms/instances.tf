# BEGIN ANSIBLE MANAGED BLOCK - dear_lamb
resource "aws_instance" "dear_lamb_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a98b5f222a0d2396"
  instance_type = var.instance_type
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "dear-lamb-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
  }
}
# END ANSIBLE MANAGED BLOCK - dear_lamb
# BEGIN ANSIBLE MANAGED BLOCK - vast_monkey
resource "aws_instance" "vast_monkey_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a98b5f222a0d2396"
  instance_type = var.instance_type
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "vast-monkey-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
  }
}
# END ANSIBLE MANAGED BLOCK - vast_monkey
# BEGIN ANSIBLE MANAGED BLOCK - novel_dory
resource "aws_instance" "novel_dory_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a98b5f222a0d2396"
  instance_type = var.instance_type
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "novel-dory-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
  }
}
# END ANSIBLE MANAGED BLOCK - novel_dory
# BEGIN ANSIBLE MANAGED BLOCK - true_cougar
resource "aws_instance" "true_cougar_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a98b5f222a0d2396"
  instance_type = var.instance_type
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "true-cougar-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
  }
}
# END ANSIBLE MANAGED BLOCK - true_cougar
# BEGIN ANSIBLE MANAGED BLOCK - ruling_racer
resource "aws_instance" "ruling_racer_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a98b5f222a0d2396"
  instance_type = var.instance_type
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "ruling-racer-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
  }
}
# END ANSIBLE MANAGED BLOCK - ruling_racer

# BEGIN ANSIBLE MANAGED BLOCK - windows_template
resource "aws_instance" "windows_template_vm" {
  provider = aws.eu_central_1

  # Windows Server 2022 Base AMI for eu-central-1
  ami           = "ami-09f31a65dd0bdca78"  # Microsoft Windows Server 2022 Base
  instance_type = "t3.medium"  # Windows requires more resources than t2.micro
  # key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [aws_security_group.windows_winrm_sg.id]

  # Enable detailed monitoring for Windows instances
  monitoring = true

  # User data script to configure WinRM for Ansible
  user_data = base64encode(templatefile("${path.module}/windows_userdata.ps1", {
    admin_password = "AnsibleDemo123!"
  }))

  tags = {
    Name        = "windows-template-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OS          = "Windows Server 2022"
    WinRM       = "Enabled"
  }
}

# Security group specifically for Windows WinRM access
resource "aws_security_group" "windows_winrm_sg" {
  provider = aws.eu_central_1
  
  name        = "windows-winrm-sg-eu-central-1"
  description = "Allow WinRM and RDP access for Windows instances"
  vpc_id      = module.eu_central_1[0].vpc_id

  # WinRM HTTP (5985)
  ingress {
    from_port   = 5985
    to_port     = 5985
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "WinRM HTTP"
  }

  # WinRM HTTPS (5986)
  ingress {
    from_port   = 5986
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "WinRM HTTPS"
  }

  # RDP (3389) - for debugging if needed
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "RDP"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "windows-winrm-sg-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
  }
}

# Output the Windows instance details
output "windows_template_vm" {
  description = "Windows template VM details"
  value = {
    id         = aws_instance.windows_template_vm.id
    public_ip  = aws_instance.windows_template_vm.public_ip
    public_dns = aws_instance.windows_template_vm.public_dns
    winrm_http = "http://${aws_instance.windows_template_vm.public_ip}:5985/wsman"
    winrm_https = "https://${aws_instance.windows_template_vm.public_ip}:5986/wsman"
    instance_type = aws_instance.windows_template_vm.instance_type
    admin_user = "Administrator"
    admin_password = "AnsibleDemo123!"  # In production, use AWS Secrets Manager
  }
  sensitive = true
}
# END ANSIBLE MANAGED BLOCK - windows_template
# BEGIN ANSIBLE MANAGED BLOCK - deep_roughy
resource "aws_instance" "deep_roughy_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a98b5f222a0d2396"
  instance_type = var.instance_type
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "deep-roughy-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
  }
}
# END ANSIBLE MANAGED BLOCK - deep_roughy
# BEGIN ANSIBLE MANAGED BLOCK - witty_leech
resource "aws_instance" "witty_leech_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a98b5f222a0d2396"
  instance_type = var.instance_type
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "witty-leech-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
  }
}
# END ANSIBLE MANAGED BLOCK - witty_leech
