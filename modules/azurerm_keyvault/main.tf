resource "azurerm_key_vault" "kv" {
  name                        = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = var.sku_name

  dynamic "access_policy" {
    for_each = var.object_id != null ? [var.object_id] : []
    content {
      tenant_id = var.tenant_id
      object_id = access_policy.value

      secret_permissions = [
        "Get", "List", "Set", "Delete", "Purge", "Recover"
      ]
    }
  }

  tags = var.tags
}

