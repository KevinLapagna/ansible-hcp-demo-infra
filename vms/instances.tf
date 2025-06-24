# BEGIN ANSIBLE MANAGED BLOCK - finer_colt
resource "aws_instance" "finer_colt_vm" {
  provider = aws.eu_central_1

  ami           = "ami-09f31a65dd0bdca78"  # Microsoft Windows Server 2022 Base
  # ami         = "ami-0a98b5f222a0d2396"
  instance_type = "t3.medium"  # Windows requires more resources than t2.micro
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].windows_winrm_security_group_id]

  # Enable detailed monitoring for Windows instances
  monitoring = true

  # User data script to configure WinRM with certificate authentication
  user_data = base64encode(templatefile("${path.module}/windows-winrm-basic.ps1", {
    certificate_content = file("${path.module}/aap-client-certificate.crt")
  }))

  tags = {
    Name        = "finer-colt-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Windows"
    RequestID   = "REQ380816837"
  }
}
# END ANSIBLE MANAGED BLOCK - finer_colt
