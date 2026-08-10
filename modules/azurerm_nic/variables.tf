variable "nic_name" {
  type        = string
  description = "Network Interface Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to connect NIC to"
}

variable "private_ip_address_allocation" {
  type        = string
  description = "Dynamic or Static"
  default     = "Dynamic"
}

variable "public_ip_address_id" {
  type        = string
  description = "Optional Public IP ID"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
