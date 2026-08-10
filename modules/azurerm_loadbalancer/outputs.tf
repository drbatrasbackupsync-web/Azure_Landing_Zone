output "lb_id" {
  value       = azurerm_lb.lb.id
  description = "The ID of the Load Balancer"
}

output "backend_address_pool_id" {
  value       = azurerm_lb_backend_address_pool.bap.id
  description = "The ID of the Backend Address Pool"
}
