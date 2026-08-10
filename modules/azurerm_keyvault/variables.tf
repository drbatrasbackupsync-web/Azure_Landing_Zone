variable "keyvault_name" {
  type        = string
  description = "Key Vault Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "tenant_id" {
  type        = string
  description = "Azure Active Directory Tenant ID"
}

variable "sku_name" {
  type    = string
  default = "standard"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}

variable "object_id" {
  type        = string
  description = "Optional Object ID for Key Vault access policy"
  default     = null
}

