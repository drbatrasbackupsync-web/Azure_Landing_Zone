variable "vm_name" {
  type        = string
  description = "Virtual Machine Name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "vm_size" {
  type        = string
  description = "VM SKU Size"
  default     = "Standard_B2s"
}

variable "zone" {
  type        = string
  description = "Availability Zone"
  default     = "1"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
  default     = "azureuser"
}

variable "admin_password" {
  type        = string
  description = "Admin password for the VM"
  sensitive   = true
}

variable "network_interface_ids" {
  type        = list(string)
  description = "List of Network Interface IDs attached to VM"
}

variable "storage_account_type" {
  type        = string
  description = "OS Disk Storage Account Type"
  default     = "Standard_LRS"
}

variable "image_publisher" {
  type    = string
  default = "Canonical"
}

variable "image_offer" {
  type    = string
  default = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
  type    = string
  default = "22_04-lts"
}

variable "image_version" {
  type    = string
  default = "latest"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
