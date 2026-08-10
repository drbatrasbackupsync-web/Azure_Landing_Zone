variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group"
}

variable "location" {
  type        = string
  description = "Azure region for the resource group"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the resource group"
  default     = {}
}
