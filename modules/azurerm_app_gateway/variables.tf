variable "appgw_name" {
  type        = string
  description = "Application Gateway Name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "sku_name" {
  type    = string
  default = "Standard_v2"
}

variable "sku_tier" {
  type    = string
  default = "Standard_v2"
}

variable "capacity" {
  type    = number
  default = 2
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID dedicated for Application Gateway"
}

variable "public_ip_address_id" {
  type        = string
  description = "Public IP ID for Application Gateway frontend"
}

variable "zones" {
  type        = list(string)
  description = "Application Gateway Availability Zones"
  default     = ["1"]
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
