# BEGIN ANSIBLE MANAGED BLOCK - alert_osprey
resource "aws_instance" "alert_osprey_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a8e2e55de614b2b1"
  instance_type = "t2.micro"
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "alert-osprey-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Linux"
    RequestID   = "REQ491633800"
  }
}
# END ANSIBLE MANAGED BLOCK - alert_osprey
# BEGIN ANSIBLE MANAGED BLOCK - in_magpie
resource "aws_instance" "in_magpie_vm" {
  provider = aws.eu_central_1

  ami           = "ami-09f31a65dd0bdca78"
  instance_type = "t3.medium"
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].windows_winrm_security_group_id]

  # Enable detailed monitoring for Windows instances
  monitoring = true

  # User data script to configure WinRM with certificate authentication
  user_data = base64encode(templatefile("${path.module}/windows-winrm-basic.ps1", {
    certificate_content = file("${path.module}/aap-client-certificate.crt")
  }))

  tags = {
    Name        = "in-magpie-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Windows"
    RequestID   = "REQ841004789"
  }
}
# END ANSIBLE MANAGED BLOCK - in_magpie
# BEGIN ANSIBLE MANAGED BLOCK - social_cow
resource "aws_instance" "social_cow_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a8e2e55de614b2b1"
  instance_type = "t2.micro"
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "social-cow-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Linux"
    RequestID   = "REQ792103635"
  }
}
# END ANSIBLE MANAGED BLOCK - social_cow
