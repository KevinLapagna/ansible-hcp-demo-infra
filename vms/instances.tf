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
