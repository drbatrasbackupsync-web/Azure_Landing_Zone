variable "lb_name" {
  type        = string
  description = "Load Balancer Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "sku" {
  type        = string
  description = "Load Balancer SKU"
  default     = "Standard"
}

variable "frontend_ip_name" {
  type    = string
  default = "FrontendIP"
}

variable "public_ip_address_id" {
  type        = string
  description = "Public IP ID if public load balancer"
  default     = null
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID if internal load balancer"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
