# Enterprise Azure Terraform Infrastructure & DevOps Security Workflow

Welcome to the **Modular Azure Infrastructure Repository**. This repository is structured according to enterprise DevOps standards, featuring child modules, multi-environment deployments (`preprod` and `prod`), automated GitHub Actions security CI/CD, and a two-tier DevOps governance model (**Sr. DevOps Engineer / Head** and **DevOps Engineer**).

---

## 🏗 Directory Architecture

```text
08_06_2026/
├── .github/
│   ├── workflows/
│   │   └── security_checks.yml    # Automated CI Security & Linting Pipeline
│   └── PULL_REQUEST_TEMPLATE.md   # PR Checklist for DevOps Engineers
├── modules/                        # Reusable Child Infrastructure Modules
│   ├── azurerm_resource_group/
│   ├── azurerm_virtual_network/
│   ├── azurerm_subnet/
│   ├── azurerm_nic/
│   ├── azurerm_pip/
│   ├── azurerm_virtual_machine/
│   ├── azurerm_nsg/
│   ├── azurerm_loadbalancer/
│   ├── azurerm_app_gateway/
│   └── azurerm_keyvault/
├── environments/                   # Parent Environment Configurations
│   ├── preprod/                    # Pre-Production Infrastructure Environment
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars
│   │   ├── provider.tf
│   │   ├── data.tf
│   │   └── backend.tf
│   └── prod/                       # Production Infrastructure Environment
│       ├── main.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       ├── provider.tf
│       ├── data.tf
│       └── backend.tf
├── .gitignore                      # Terraform State & Secret Exclusion Rules
└── README.md                       # Repository Master Guide
```

---

## 👥 DevOps Roles & Workflow Governance

### 1. Sr. DevOps Engineer / Head (Architect & Reviewer)
* **Responsibilities**:
  - Sets up repository standards, child modules, and Azure state backends.
  - Configures GitHub Branch Protection rules on `main` (requires passing CI + 1 approval).
  - Maintains `.github/workflows/security_checks.yml` security policies.
  - Reviews Pull Requests (PRs) raised by DevOps Engineers.
  - Approves and executes final `terraform apply` on Production (`prod`).

### 2. DevOps Engineer (Implementer & Contributor)
* **Responsibilities**:
  - Clones repository and creates a dedicated `feature/<feature-name>` branch.
  - Modifies or adds infrastructure code in `modules/` or `environments/`.
  - Runs **local security tools** (`terraform fmt`, `terraform validate`, `tflint`, `tfsec`, `checkov`).
  - Commits code, pushes feature branch to GitHub, and raises a **Pull Request (PR)** using the PR template.
  - Fixes any security or formatting issues flagged by GitHub CI or Sr. DevOps Lead.

---

## 🛡 Security Tools & Local Scanners

Before pushing code or opening a Pull Request, DevOps Engineers **MUST** run local checks.

| Tool | Purpose | Local Command |
| :--- | :--- | :--- |
| **Terraform Format** | Ensures standard HCL formatting | `terraform fmt -check -recursive` |
| **Terraform Validate** | Checks syntax and block schema | `cd environments/preprod && terraform init -backend=false && terraform validate` |
| **TFLint** | Linter catching provider errors & conventions | `tflint` |
| **TFSec** | Static security scanner for Azure resources | `tfsec .` |
| **Checkov** | Policy-as-code security compliance scanner | `checkov -d . --framework terraform` |
| **Trivy** | Vulnerability & IaC scanner | `trivy config .` |

### Installing Security Tools Locally

* **Windows (Chocolatey / Scoop)**:
  ```powershell
  choco install terraform-tfsec tflint checkov trivy
  # OR using Scoop
  scoop install tfsec tflint checkov trivy
  ```
* **macOS (Homebrew)**:
  ```bash
  brew install tfsec tflint checkov trivy
  ```

---

## 🔄 End-to-End Git Feature Branch & PR Process

Follow these step-by-step instructions whenever you make infrastructure changes:

### Step 1: Clone & Checkout a Feature Branch
```bash
# Ensure you are on latest main branch
git checkout main
git pull origin main

# Create a new feature branch (e.g., feature/add-nsg-rules or feature/preprod-hardening)
git checkout -b feature/preprod-hardening
```

### Step 2: Make Code Changes & Run Local Security Checks
Modify your HCL files in `modules/` or `environments/preprod/`.

Run local verification:
```bash
# 1. Format code
terraform fmt -recursive

# 2. Validate configuration
cd environments/preprod
terraform init -backend=false
terraform validate
cd ../..

# 3. Security Scanning
tfsec .
checkov -d . --framework terraform
```

### Step 3: Commit Code & Push Feature Branch
```bash
git add .
git commit -m "feat(preprod): update NSG security rules and Key Vault access policies"
git push origin feature/preprod-hardening
```

### Step 4: Raise a Pull Request (PR) on GitHub
1. Navigate to the repository on GitHub.
2. Click **Compare & pull request** for your branch `feature/preprod-hardening`.
3. Complete the PR template checklist:
   - Mark local check boxes `[x]`.
   - Provide summary of changes.
4. Submit the Pull Request against `main`.

### Step 5: CI Security Verification & Sr. DevOps Review
1. GitHub Actions automatically executes `.github/workflows/security_checks.yml`.
2. All 3 stages (**Format & Validate**, **TFLint**, **TFSec / Checkov Scans**) must show green checkmarks ✅.
3. The **Sr. DevOps Lead** reviews the PR, verifies security compliance, and clicks **Approve & Merge**.

---

## 🚀 Environment Deployment Guide

### Deploying Pre-Production (`preprod`)
```bash
cd environments/preprod

# Initialize Terraform with Azure Remote State Backend
terraform init

# Plan changes
terraform plan -out=tfplan

# Apply changes after review
terraform apply tfplan
```

### Deploying Production (`prod`)
> [!IMPORTANT]
> Production deployment must only be performed after successful validation in `preprod` and approval from Sr. DevOps Engineer / Head.

```bash
cd environments/prod

terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

---

## 🔐 Key Vault & Secret Management Policy

- **No Plaintext Secrets**: Passwords (e.g. VM admin passwords) must never be hardcoded in `.tf` or `.tfvars` files.
- **Key Vault Integration**: Secrets are dynamically injected or fetched via Azure Key Vault data sources or Key Vault child modules (`modules/azurerm_keyvault`).
