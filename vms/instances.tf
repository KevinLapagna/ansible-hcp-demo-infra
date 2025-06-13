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
