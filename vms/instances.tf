# ==> EC2 Instance - Only in eu-central-1 <==
resource "aws_instance" "native_lion_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a98b5f222a0d2396"
  instance_type = var.instance_type
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id
  
  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "native-lion-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "Terraform"
    Region      = "eu-central-1"
  }
}
# BEGIN ANSIBLE MANAGED BLOCK - holy_bison
resource "aws_instance" "holy_bison_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a98b5f222a0d2396"
  instance_type = var.instance_type
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "holy-bison-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
  }
}
# END ANSIBLE MANAGED BLOCK - holy_bison
# BEGIN ANSIBLE MANAGED BLOCK - eager_coyote
resource "aws_instance" "eager_coyote_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a98b5f222a0d2396"
  instance_type = var.instance_type
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "eager-coyote-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
  }
}
# END ANSIBLE MANAGED BLOCK - eager_coyote
# BEGIN ANSIBLE MANAGED BLOCK - clean_weasel
resource "aws_instance" "clean_weasel_vm" {
  provider = aws.eu_central_1

  ami           = "ami-0a98b5f222a0d2396"
  instance_type = var.instance_type
  key_name      = module.eu_central_1[0].key_pair_name
  subnet_id     = module.eu_central_1[0].subnet_id

  vpc_security_group_ids = [module.eu_central_1[0].security_group_id]

  tags = {
    Name        = "clean-weasel-VM-eu-central-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "eu-central-1"
  }
}
# END ANSIBLE MANAGED BLOCK - clean_weasel
# BEGIN ANSIBLE MANAGED BLOCK - rapid_hippo
resource "aws_instance" "rapid_hippo_vm" {
  provider = aws.us_east_1

  ami           = "ami-09614d9d7c2f96d00"
  instance_type = var.instance_type
  key_name      = module.us_east_1[0].key_pair_name
  subnet_id     = module.us_east_1[0].subnet_id

  vpc_security_group_ids = [module.us_east_1[0].security_group_id]

  tags = {
    Name        = "rapid-hippo-VM-us-east-1"
    Environment = "Development"
    CreatedBy   = "AAP"
    Region      = "us-east-1"
  }
}
# END ANSIBLE MANAGED BLOCK - rapid_hippo
