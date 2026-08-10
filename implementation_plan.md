# Comprehensive Azure Terraform Modular Architecture Plan

This plan details the creation of a production-grade, modular Azure Terraform codebase in `d:/Study/Practice/08_06_2026`. The architecture incorporates separate environments (**Prod** and **Preprod**), Azure Blob Storage remote state backend (`tfstate`), Azure Key Vault integration, and reusable child modules.

## User Review Required

> [!NOTE]
> Please review the environment backend configuration details. The `backend.tf` files will use placeholders for `resource_group_name`, `storage_account_name`, `container_name`, and `key` which can be populated or passed via `terraform init -backend-config=...`.

> [!IMPORTANT]
> Key Vault module handles secrets (e.g., VM admin passwords) securely so plaintext secrets are not stored in `.tfvars`.

## Proposed Folder Structure

```
08_06_2026/
├── modules/
│   ├── azurerm_resource_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── azurerm_virtual_network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── azurerm_subnet/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── azurerm_nic/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── data.tf
│   ├── azurerm_pip/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── azurerm_virtual_machine/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── azurerm_nsg/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── azurerm_loadbalancer/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── azurerm_app_gateway/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── azurerm_keyvault/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/
    ├── prod/
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── terraform.tfvars
    │   ├── data.tf
    │   ├── backend.tf
    │   └── provider.tf
    └── preprod/
        ├── main.tf
        ├── variables.tf
        ├── terraform.tfvars
        ├── data.tf
        ├── backend.tf
        └── provider.tf
```

---

## Proposed Changes

### Child Modules

#### [NEW] `modules/azurerm_resource_group/`
- `main.tf`: Defines `azurerm_resource_group`.
- `variables.tf`: `rg_name`, `location`, `tags`.
- `outputs.tf`: Exports `resource_group_name`, `location`, `id`.

#### [NEW] `modules/azurerm_virtual_network/`
- `main.tf`: Defines `azurerm_virtual_network`.
- `variables.tf`: `vnet_name`, `address_space`, `location`, `rg_name`, `tags`.
- `outputs.tf`: Exports `vnet_name`, `vnet_id`, `address_space`.

#### [NEW] `modules/azurerm_subnet/`
- `main.tf`: Defines `azurerm_subnet`.
- `variables.tf`: `subnet_name`, `vnet_name`, `rg_name`, `address_prefixes`.
- `outputs.tf`: Exports `subnet_id`, `subnet_name`.

#### [NEW] `modules/azurerm_nic/`
- `main.tf`: Defines `azurerm_network_interface` with IP configuration.
- `variables.tf`: `nic_name`, `location`, `rg_name`, `subnet_id`, `public_ip_id`.
- `outputs.tf`: Exports `nic_id`, `nic_name`, `private_ip_address`.
- `data.tf`: Reads existing resources/configurations if needed (e.g. existing subnet or client config).

#### [NEW] `modules/azurerm_pip/`
- `main.tf`: Defines `azurerm_public_ip`.
- `variables.tf`: `pip_name`, `location`, `rg_name`, `allocation_method`, `sku`.
- `outputs.tf`: Exports `pip_id`, `ip_address`.

#### [NEW] `modules/azurerm_virtual_machine/`
- `main.tf`: Defines `azurerm_linux_virtual_machine` / `azurerm_windows_virtual_machine`.
- `variables.tf`: `vm_name`, `location`, `rg_name`, `size`, `admin_username`, `admin_password_secret_id`, `nic_ids`, `os_disk`.
- `outputs.tf`: Exports `vm_id`.

#### [NEW] `modules/azurerm_nsg/`
- `main.tf`: Defines `azurerm_network_security_group` and `azurerm_network_security_rule` resources.
- `variables.tf`: `nsg_name`, `location`, `rg_name`, `security_rules`.
- `outputs.tf`: Exports `nsg_id`, `nsg_name`.

#### [NEW] `modules/azurerm_loadbalancer/`
- `main.tf`: Defines `azurerm_lb`, backend pools, health probes, and rules.
- `variables.tf`: `lb_name`, `location`, `rg_name`, `type` (Public/Internal), `frontend_ip_config`.
- `outputs.tf`: Exports `lb_id`, `frontend_ip_configuration`.

#### [NEW] `modules/azurerm_app_gateway/`
- `main.tf`: Defines `azurerm_application_gateway` with HTTP listeners, backend pools, and rules.
- `variables.tf`: `appgw_name`, `location`, `rg_name`, `sku`, `gateway_ip_configuration`, `frontend_port`, `frontend_ip_configuration`.
- `outputs.tf`: Exports `appgw_id`.

#### [NEW] `modules/azurerm_keyvault/`
- `main.tf`: Defines `azurerm_key_vault` and secrets.
- `variables.tf`: `kv_name`, `location`, `rg_name`, `tenant_id`, `sku_name`.
- `outputs.tf`: Exports `key_vault_id`, `key_vault_uri`.

---

### Parent Modules (Environments)

#### [NEW] `environments/prod/` and `environments/preprod/`
- `provider.tf`: Standard `azurerm` provider block with version constraints.
- `backend.tf`: Configured for Azure Storage Account backend storing `.tfstate`.
- `data.tf`: Client configuration (`azurerm_client_config`) and current tenant data.
- `variables.tf`: Environment-specific variables.
- `terraform.tfvars`: Environment parameter values (e.g. standard naming prefixes, IP CIDRs, SKU tiers).
- `main.tf`: Instantiates all child modules in sequence (RG -> VNet -> Subnets -> NSG -> KeyVault -> PIP -> NIC -> VM -> LB -> AppGW).

---

## Verification Plan

### Automated Tests
- Run `terraform fmt -check -recursive` across all modules and environment configurations.
- Run `terraform init -backend=false` and `terraform validate` inside `environments/prod` and `environments/preprod`.

### Manual Verification
- Review generated HCL code to ensure proper input/output wiring between child modules in `main.tf`.
