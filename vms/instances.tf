# BEGIN ANSIBLE MANAGED BLOCK - kevs01
resource "aws_instance" "kevs01_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a8e2e55de614b2b1"
  instance_type = "t2.micro"
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "kevs01-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Linux"
    RequestID   = "myrequestid"
  }
}
# END ANSIBLE MANAGED BLOCK - kevs01
# BEGIN ANSIBLE MANAGED BLOCK - close_seal
resource "aws_instance" "close_seal_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a8e2e55de614b2b1"
  instance_type = "t2.micro"
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "close-seal-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
    OsType      = "Linux"
    RequestID   = "REQ471834162"
  }
}
# END ANSIBLE MANAGED BLOCK - close_seal
