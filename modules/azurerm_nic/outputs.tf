output "nic_id" {
  value       = azurerm_network_interface.nic.id
  description = "The ID of the Network Interface"
}

output "nic_name" {
  value       = azurerm_network_interface.nic.name
  description = "The name of the Network Interface"
}

output "private_ip_address" {
  value       = azurerm_network_interface.nic.private_ip_address
  description = "Private IP address assigned to NIC"
}
