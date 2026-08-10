variable "environment" {
  type        = string
  description = "Environment name (prod/preprod)"
  default     = "preprod"
}

variable "location" {
  type        = string
  description = "Primary Azure region"
  default     = "Central India"
}

variable "zone" {
  type        = string
  description = "Availability Zone"
  default     = "1"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Virtual Network CIDR block"
}

variable "subnet_prefixes" {
  type        = map(list(string))
  description = "Map of subnet prefixes"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "vm_size" {
  type        = string
  description = "VM SKU Size"
  default     = "Standard_B1s"
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
