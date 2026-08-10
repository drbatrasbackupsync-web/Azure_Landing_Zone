# 1. Resource Group
module "resource_group" {
  source              = "../../modules/azurerm_resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# 2. Virtual Network
module "virtual_network" {
  source              = "../../modules/azurerm_virtual_network"
  vnet_name           = "${var.environment}-vnet"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

# 3. Subnets
module "subnet_vm" {
  source              = "../../modules/azurerm_subnet"
  subnet_name         = "${var.environment}-vm-subnet"
  resource_group_name = module.resource_group.resource_group_name
  vnet_name           = module.virtual_network.vnet_name
  address_prefixes    = var.subnet_prefixes["vm"]
}

module "subnet_appgw" {
  source              = "../../modules/azurerm_subnet"
  subnet_name         = "${var.environment}-appgw-subnet"
  resource_group_name = module.resource_group.resource_group_name
  vnet_name           = module.virtual_network.vnet_name
  address_prefixes    = var.subnet_prefixes["appgw"]
}

# 4. NSG
module "nsg" {
  source              = "../../modules/azurerm_nsg"
  nsg_name            = "${var.environment}-nsg"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  tags                = var.tags

  security_rules = [
    {
      name                       = "AllowSSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowHTTP"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

# 5. Key Vault
module "keyvault" {
  source              = "../../modules/azurerm_keyvault"
  keyvault_name       = "${var.environment}-kv-${substr(md5(module.resource_group.resource_group_id), 0, 6)}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = var.tags
}

# 6. Public IPs
module "pip_vm" {
  source              = "../../modules/azurerm_pip"
  pip_name            = "${var.environment}-vm-pip"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  zones               = [var.zone]
  tags                = var.tags
}

module "pip_lb" {
  source              = "../../modules/azurerm_pip"
  pip_name            = "${var.environment}-lb-pip"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  zones               = [var.zone]
  tags                = var.tags
}

module "pip_appgw" {
  source              = "../../modules/azurerm_pip"
  pip_name            = "${var.environment}-appgw-pip"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  zones               = [var.zone]
  tags                = var.tags
}

# 7. NIC
module "nic" {
  source               = "../../modules/azurerm_nic"
  nic_name             = "${var.environment}-vm-nic"
  location             = module.resource_group.location
  resource_group_name  = module.resource_group.resource_group_name
  subnet_id            = module.subnet_vm.subnet_id
  public_ip_address_id = module.pip_vm.pip_id
  tags                 = var.tags
}

# 8. Virtual Machine
module "virtual_machine" {
  source                = "../../modules/azurerm_virtual_machine"
  vm_name               = "${var.environment}-vm"
  location              = module.resource_group.location
  resource_group_name   = module.resource_group.resource_group_name
  vm_size               = var.vm_size
  zone                  = var.zone
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [module.nic.nic_id]
  tags                  = var.tags
}

# 9. Load Balancer
module "loadbalancer" {
  source               = "../../modules/azurerm_loadbalancer"
  lb_name              = "${var.environment}-lb"
  location             = module.resource_group.location
  resource_group_name  = module.resource_group.resource_group_name
  public_ip_address_id = module.pip_lb.pip_id
  tags                 = var.tags
}

# 10. App Gateway
module "app_gateway" {
  source               = "../../modules/azurerm_app_gateway"
  appgw_name           = "${var.environment}-appgw"
  location             = module.resource_group.location
  resource_group_name  = module.resource_group.resource_group_name
  subnet_id            = module.subnet_appgw.subnet_id
  public_ip_address_id = module.pip_appgw.pip_id
  zones                = [var.zone]
  tags                 = var.tags
}
