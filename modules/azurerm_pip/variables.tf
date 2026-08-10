variable "pip_name" {
  type        = string
  description = "Public IP Name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "allocation_method" {
  type        = string
  description = "Static or Dynamic"
  default     = "Static"
}

variable "sku" {
  type        = string
  description = "Standard or Basic"
  default     = "Standard"
}

variable "zones" {
  type        = list(string)
  description = "Public IP Availability Zones"
  default     = ["1"]
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
