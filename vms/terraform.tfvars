# Multi-Region VM Configuration

# Regions to deploy to (you can add or remove regions as needed)
aws_regions = ["us-east-1", "eu-central-1", "eu-west-1"]

# Instance Configuration
instance_type = "t2.micro"

# SSH Configuration
user_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCv2uH4JB49zPUlAqQiOoVWOXQtL7enFcDnz1hlnm+aKfL+CJEyTzW/R/+oX7RrrhpClqlbcIfgtmXYKoSHdHF15voNVulmfeiCn2Tzddco/5Djo7rdDQMTKx3vlDrkGxJFVBgb1uTe4IbXe/Zgb2nen8ipAWLv3X/I/j3sG0PBa5qZAjvUsp+XrFQ5tMk/PiuT4ET0A1gUy3ASw+IyIGoH4eW8TT2j5iaEPTvWQgq77zlyLv61mRMB2XybDGmB9gHESw0KrRH+QjVSJsdcSsdgGlaNGOQLmFJzf41xxCoLumrjqk5hr3JHRv8Hcxpgs5yTxRwrsICzuRvnpQdScSM7pG7vtjlRbfHvVA+sQV4NrwfK37ArmY+hxdHg2xkN43XKvTOCWsUCvAlagXC0qh+vw2lnEbP5zheMNMGYoQ3G3DtCj+L9Glz10kervEkUefmv1afVrzW0QRJ1U+0Q5MNGr9L0wVpC1G1BLDEekq5d4/z49BI1iasCcidfT6BJZRrZ9vyH/gH3T9GWm5w1vIXWDYhFaOxpjhVhhiQOnDC6FI8j7vxwiez3G+A3/ybv1aPcSuIDI6T8aChL1NNxzs87CmuI+xdKgFeTRvgeEFki2jcwtTcZbAx9H7fzXEaVzaX+OgDa5BNYhndI74Bf1V4hG77IuIvMZp2uCDl0zU/fKQ== ansible@aap"
key_pair_name   = "aap-ssh-key"  # Name of the SSH key pair to be created



# Network Configuration (Optional - defaults are provided in variables.tf)
# Uncomment and modify if you want to override the default CIDR blocks

# vpc_cidr_blocks = {
#   "us-east-1"    = "10.0.0.0/16"
#   "eu-central-1" = "10.1.0.0/16"
#   "eu-west-1"    = "10.2.0.0/16"
# }

# subnet_cidr_blocks = {
#   "us-east-1"    = "10.0.1.0/24"
#   "eu-central-1" = "10.1.1.0/24"
#   "eu-west-1"    = "10.2.1.0/24"
# }