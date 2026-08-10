# Infrastructure Remediation & Hardening Walkthrough

All proposed changes in the approved implementation plan have been applied and verified.

## 🛠 Changes Implemented

### 1. Key Vault Module Access Policy
- **Files**:
  - [modules/azurerm_keyvault/variables.tf](file:///d:/Study/Practice/10.08.2026_Git%20push%20_PR%20Raise/Azure_Landing_Zone/modules/azurerm_keyvault/variables.tf#L32-L36)
  - [modules/azurerm_keyvault/main.tf](file:///d:/Study/Practice/10.08.2026_Git%20push%20_PR%20Raise/Azure_Landing_Zone/modules/azurerm_keyvault/main.tf#L12-L22)
- Added dynamic `access_policy` block to grant secret permissions (`Get`, `List`, `Set`, `Delete`, `Purge`, `Recover`) when an `object_id` is supplied.

### 2. Application Gateway Backend Pool Targets
- **Files**:
  - [modules/azurerm_app_gateway/variables.tf](file:///d:/Study/Practice/10.08.2026_Git%20push%20_PR%20Raise/Azure_Landing_Zone/modules/azurerm_app_gateway/variables.tf#L53-L57)
  - [modules/azurerm_app_gateway/main.tf](file:///d:/Study/Practice/10.08.2026_Git%20push%20_PR%20Raise/Azure_Landing_Zone/modules/azurerm_app_gateway/main.tf#L34-L37)
- Added `backend_ip_addresses` input to dynamically configure IP targets on the App Gateway backend pool.

### 3. Resource Associations & Wiring
- **Files**:
  - [environments/preprod/main.tf](file:///d:/Study/Practice/10.08.2026_Git%20push%20_PR%20Raise/Azure_Landing_Zone/environments/preprod/main.tf#L154-L167)
  - [environments/prod/main.tf](file:///d:/Study/Practice/10.08.2026_Git%20push%20_PR%20Raise/Azure_Landing_Zone/environments/prod/main.tf#L154-L167)
- Added `azurerm_subnet_network_security_group_association` to bind `module.nsg` to `module.subnet_vm`.
- Added `azurerm_network_interface_backend_address_pool_association` to attach `module.nic` to `module.loadbalancer.backend_address_pool_id`.
- Passed `module.nic.private_ip_address` into `module.app_gateway.backend_ip_addresses`.
- Passed `data.azurerm_client_config.current.object_id` to `module.keyvault`.

### 4. Root Environment Outputs
- **Files**:
  - [environments/preprod/outputs.tf](file:///d:/Study/Practice/10.08.2026_Git%20push%20_PR%20Raise/Azure_Landing_Zone/environments/preprod/outputs.tf)
  - [environments/prod/outputs.tf](file:///d:/Study/Practice/10.08.2026_Git%20push%20_PR%20Raise/Azure_Landing_Zone/environments/prod/outputs.tf)
- Created output definitions for Resource Group name, VNet ID, VM Private IP, VM Public IP, Load Balancer Public IP, App Gateway Public IP, and Key Vault URI.

---

## 🧪 Verification Results

| Check | Command | Status |
| :--- | :--- | :---: |
| **HCL Format Check** | `terraform fmt -check -recursive` | ✅ PASSED |
| **Preprod Validation** | `cd environments/preprod && terraform validate` | ✅ PASSED |
| **Prod Validation** | `cd environments/prod && terraform validate` | ✅ PASSED |
