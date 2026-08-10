output "appgw_id" {
  value       = azurerm_application_gateway.appgw.id
  description = "The ID of the Application Gateway"
}

output "appgw_name" {
  value       = azurerm_application_gateway.appgw.name
  description = "The name of the Application Gateway"
}
