resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  tags                = var.tags

  frontend_ip_configuration {
    name                 = var.frontend_ip_name
    public_ip_address_id = var.public_ip_address_id
    subnet_id            = var.subnet_id
  }
}

resource "azurerm_lb_backend_address_pool" "bap" {
  name            = "${var.lb_name}-backend-pool"
  loadbalancer_id = azurerm_lb.lb.id
}
