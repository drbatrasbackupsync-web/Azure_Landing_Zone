variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "address_space" {
  type        = list(string)
  description = "Address space CIDR blocks for VNet"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the Virtual Network"
  default     = {}
}
