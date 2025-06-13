# BEGIN ANSIBLE MANAGED BLOCK - decent_locust
resource "aws_instance" "decent_locust_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a98b5f222a0d2396"
  instance_type = var.instance_type
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "decent-locust-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
  }
}
# END ANSIBLE MANAGED BLOCK - decent_locust
# BEGIN ANSIBLE MANAGED BLOCK - fair_moose
resource "aws_instance" "fair_moose_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a98b5f222a0d2396"
  instance_type = var.instance_type
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "fair-moose-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
  }
}
# END ANSIBLE MANAGED BLOCK - fair_moose
# BEGIN ANSIBLE MANAGED BLOCK - needed_raptor
resource "aws_instance" "needed_raptor_vm" {
  provider = aws.eu_west_1

  ami           = "ami-05fd4b86367f3a4b9"
  instance_type = var.instance_type
  key_name      = module.eu_west_1[0].key_pair_name
  subnet_id     = module.eu_west_1[0].subnet_id

  vpc_security_group_ids = [module.eu_west_1[0].security_group_id]

  tags = {
    Name        = "needed-raptor-VM-eu-west-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-west-1"
  }
}
# END ANSIBLE MANAGED BLOCK - needed_raptor
