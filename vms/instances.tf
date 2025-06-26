# BEGIN ANSIBLE MANAGED BLOCK - glad_fox
resource "aws_instance" "glad_fox_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a8e2e55de614b2b1"
  instance_type = "t3.medium"
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "glad-fox-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Linux"
    RequestID   = "REQ644042705"
  }
}
# END ANSIBLE MANAGED BLOCK - glad_fox
# BEGIN ANSIBLE MANAGED BLOCK - bold_insect
resource "aws_instance" "bold_insect_vm" {
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
    Name        = "bold-insect-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Windows"
    RequestID   = "REQ390167209"
  }
}
# END ANSIBLE MANAGED BLOCK - bold_insect
# BEGIN ANSIBLE MANAGED BLOCK - fast_molly
resource "aws_instance" "fast_molly_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a8e2e55de614b2b1"
  instance_type = "t2.micro"
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "fast-molly-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Linux"
    RequestID   = "REQ413397188"
  }
}
# END ANSIBLE MANAGED BLOCK - fast_molly
# BEGIN ANSIBLE MANAGED BLOCK - normal_ewe
resource "aws_instance" "normal_ewe_vm" {
  provider = aws.eu_west_1

  ami           = "ami-02560f59f725918ec"
  instance_type = "t3.medium"
  key_name      = module.eu_west_1[0].key_pair_name
  subnet_id     = module.eu_west_1[0].subnet_id

  vpc_security_group_ids = [module.eu_west_1[0].windows_winrm_security_group_id]

  # Enable detailed monitoring for Windows instances
  monitoring = true

  # User data script to configure WinRM with certificate authentication
  user_data = base64encode(templatefile("${path.module}/windows-winrm-basic.ps1", {
    certificate_content = file("${path.module}/aap-client-certificate.crt")
  }))

  tags = {
    Name        = "normal-ewe-VM-eu-west-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-west-1"
    OsType      = "Windows"
    RequestID   = "REQ615999697"
  }
}
# END ANSIBLE MANAGED BLOCK - normal_ewe
# BEGIN ANSIBLE MANAGED BLOCK - safe_bengal
resource "aws_instance" "safe_bengal_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a8e2e55de614b2b1"
  instance_type = "t3.medium"
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "safe-bengal-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Linux"
    RequestID   = "REQ8380076"
  }
}
# END ANSIBLE MANAGED BLOCK - safe_bengal
# BEGIN ANSIBLE MANAGED BLOCK - wired_tarpon
resource "aws_instance" "wired_tarpon_vm" {
  provider = aws.eu_west_1

  ami           = "ami-02560f59f725918ec"
  instance_type = "t3.medium"
  key_name      = module.eu_west_1[0].key_pair_name
  subnet_id     = module.eu_west_1[0].subnet_id

  vpc_security_group_ids = [module.eu_west_1[0].windows_winrm_security_group_id]

  # Enable detailed monitoring for Windows instances
  monitoring = true

  # User data script to configure WinRM with certificate authentication
  user_data = base64encode(templatefile("${path.module}/windows-winrm-basic.ps1", {
    certificate_content = file("${path.module}/aap-client-certificate.crt")
  }))

  tags = {
    Name        = "wired-tarpon-VM-eu-west-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-west-1"
    OsType      = "Windows"
    RequestID   = "REQ21071394"
  }
}
# END ANSIBLE MANAGED BLOCK - wired_tarpon
