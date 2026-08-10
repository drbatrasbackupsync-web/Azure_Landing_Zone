output "vm_id" {
  value       = azurerm_linux_virtual_machine.vm.id
  description = "The ID of the Virtual Machine"
}

output "vm_name" {
  value       = azurerm_linux_virtual_machine.vm.name
  description = "The Name of the Virtual Machine"
}

output "private_ip_address" {
  value       = azurerm_linux_virtual_machine.vm.private_ip_address
  description = "Private IP address of the Virtual Machine"
}
