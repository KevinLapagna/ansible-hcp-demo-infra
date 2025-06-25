# BEGIN ANSIBLE MANAGED BLOCK - mature_gar
resource "aws_instance" "mature_gar_vm" {
  provider = aws.eu_central_1

  ami           = "ami-09f31a65dd0bdca78"  # Microsoft Windows Server 2022 Base
  # ami         = "ami-0a98b5f222a0d2396"
  instance_type = "t3.medium"  # Windows requires more resources than t2.micro
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
    Name        = "mature-gar-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Windows"
    RequestID   = "REQ701287797"
  }
}
# END ANSIBLE MANAGED BLOCK - mature_gar
# BEGIN ANSIBLE MANAGED BLOCK - honest_frog
resource "aws_instance" "honest_frog_vm" {
  provider = aws.eu_central_1

  ami           = "ami-09f31a65dd0bdca78"  # Microsoft Windows Server 2022 Base
  # ami         = "ami-0a98b5f222a0d2396"
  instance_type = "t3.medium"  # Windows requires more resources than t2.micro
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
    Name        = "honest-frog-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Windows"
    RequestID   = "REQ207350451"
  }
}
# END ANSIBLE MANAGED BLOCK - honest_frog
# BEGIN ANSIBLE MANAGED BLOCK - guided_hermit
resource "aws_instance" "guided_hermit_vm" {
  provider = aws.eu_central_1

  ami           = "ami-09f31a65dd0bdca78"  # Microsoft Windows Server 2022 Base
  # ami         = "ami-06dd92742425a21ec"
  instance_type = "t3.medium"  # Windows requires more resources than t2.micro
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
    Name        = "guided-hermit-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Windows"
    RequestID   = "REQ264532939"
  }
}
# END ANSIBLE MANAGED BLOCK - guided_hermit
# BEGIN ANSIBLE MANAGED BLOCK - vast_ray
resource "aws_instance" "vast_ray_vm" {
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
    Name        = "vast-ray-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Windows"
    RequestID   = "REQ805078118"
  }
}
# END ANSIBLE MANAGED BLOCK - vast_ray
# BEGIN ANSIBLE MANAGED BLOCK - worthy_tuna
resource "aws_instance" "worthy_tuna_vm" {
  provider = aws.eu_west_1

  ami           = "ami-0ca386c4436deaf15"
  instance_type = "t3.medium"
  key_name      = module.eu_west_1[0].key_pair_name
  subnet_id     = module.eu_west_1[0].subnet_id

  vpc_security_group_ids = [module.eu_west_1[0].security_group_id]

  tags = {
    Name        = "worthy-tuna-VM-eu-west-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-west-1"
    OsType      = "Linux"
    RequestID   = "REQ658672766"
  }
}
# END ANSIBLE MANAGED BLOCK - worthy_tuna
# BEGIN ANSIBLE MANAGED BLOCK - ace_crab
resource "aws_instance" "ace_crab_vm" {
  provider = aws.eu_west_1

  ami           = "ami-0668123a3627b3b15"
  instance_type = "t2.micro"
  key_name      = module.eu_west_1[0].key_pair_name
  subnet_id     = module.eu_west_1[0].subnet_id

  vpc_security_group_ids = [module.eu_west_1[0].security_group_id]

  tags = {
    Name        = "ace-crab-VM-eu-west-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-west-1"
    OsType      = "Linux"
    RequestID   = "REQ870019160"
  }
}
# END ANSIBLE MANAGED BLOCK - ace_crab
# BEGIN ANSIBLE MANAGED BLOCK - decent_cub
resource "aws_instance" "decent_cub_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a8e2e55de614b2b1"
  instance_type = "t3.medium"
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "decent-cub-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Linux"
    RequestID   = "REQ522964551"
  }
}
# END ANSIBLE MANAGED BLOCK - decent_cub
# BEGIN ANSIBLE MANAGED BLOCK - sought_cod
resource "aws_instance" "sought_cod_vm" {
  provider = aws.eu_central_1

  ami           = "ami-09f31a65dd0bdca78"
  instance_type = "t2.micro"
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
    Name        = "sought-cod-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Windows"
    RequestID   = "REQ232780051"
  }
}
# END ANSIBLE MANAGED BLOCK - sought_cod
# BEGIN ANSIBLE MANAGED BLOCK - proper_pig
resource "aws_instance" "proper_pig_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a8e2e55de614b2b1"
  instance_type = "t3.medium"
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "proper-pig-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Linux"
    RequestID   = "REQ641113660"
  }
}
# END ANSIBLE MANAGED BLOCK - proper_pig
