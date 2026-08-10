variable "subnet_name" {
  type        = string
  description = "Subnet Name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "vnet_name" {
  type        = string
  description = "Virtual Network Name"
}

variable "address_prefixes" {
  type        = list(string)
  description = "Subnet CIDR blocks"
}
