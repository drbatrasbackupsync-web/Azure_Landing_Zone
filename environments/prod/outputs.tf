output "resource_group_name" {
  value       = module.resource_group.resource_group_name
  description = "Resource group name"
}

output "virtual_network_id" {
  value       = module.virtual_network.vnet_id
  description = "Virtual Network ID"
}

output "vm_private_ip" {
  value       = module.nic.private_ip_address
  description = "VM Private IP Address"
}

output "vm_public_ip" {
  value       = module.pip_vm.ip_address
  description = "VM Public IP Address"
}

output "load_balancer_public_ip" {
  value       = module.pip_lb.ip_address
  description = "Load Balancer Public IP Address"
}

output "app_gateway_public_ip" {
  value       = module.pip_appgw.ip_address
  description = "Application Gateway Public IP Address"
}

output "keyvault_uri" {
  value       = module.keyvault.vault_uri
  description = "Key Vault URI"
}
