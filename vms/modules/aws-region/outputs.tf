output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.allow_inbound.id
}

output "windows_winrm_security_group_id" {
  description = "ID of the Windows WinRM security group"
  value       = aws_security_group.windows_winrm_sg.id
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.gw.id
}

output "key_pair_name" {
  description = "Name of the key pair"
  value       = aws_key_pair.vm_auth.key_name
}


