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
resource "aws_instance" "windows_template_vm_01" {
  provider = aws.eu_central_1

  # Windows Server 2022 Base AMI for eu-central-1
  ami           = "ami-09f31a65dd0bdca78"  # Microsoft Windows Server 2022 Base
  instance_type = "t3.medium"  # Windows requires more resources than t2.micro
  key_name      = "windows-debugging"
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].windows_winrm_security_group_id]

  # Enable detailed monitoring for Windows instances
  monitoring = true

  # User data script to configure WinRM with certificate authentication
  user_data = base64encode(templatefile("${path.module}/windows-winrm-setup-simple.ps1", {
    certificate_content = file("${path.module}/aap-client-certificate.crt")
  }))

  tags = {
    Name        = "windows-template-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OS          = "Windows Server 2022"
  }
}

# Output the Windows instance details
output "windows_template_vm" {
  description = "Windows template VM details"
  value = {
    id         = aws_instance.windows_template_vm_01.id
    public_ip  = aws_instance.windows_template_vm_01.public_ip
    public_dns = aws_instance.windows_template_vm_01.public_dns
    winrm_https = "https://${aws_instance.windows_template_vm_01.public_ip}:5986/wsman"
    winrm_http = "http://${aws_instance.windows_template_vm_01.public_ip}:5985/wsman"
    rdp_connection = "${aws_instance.windows_template_vm_01.public_ip}:3389"
    administrator_password = "P@ssw0rd123!"  # Fallback authentication
    instance_type = aws_instance.windows_template_vm_01.instance_type
    certificate_authentication = "Configured for AAP client certificate"
    connection_info = "Use certificate authentication with Administrator user"
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
