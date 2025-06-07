output "instance_public_ip" {
  description = "Public IP address of the EC2 instance."
  value       = module.fedora_vm.instance_public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance."
  value       = module.fedora_vm.instance_id
}