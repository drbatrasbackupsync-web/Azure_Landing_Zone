# Pull Request Title: [DevOps] Brief summary of changes

## 📝 Change Overview
- **Environment Impacted**: `[ ] Preprod` | `[ ] Prod` | `[ ] Modules`
- **Description**: Describe what changes were made (e.g. added NSG security rule, updated App Gateway SKU, etc.).

---

## 🔒 DevOps Security & Quality Checklist
Please ensure you have executed the following local checks before opening this PR:

- [ ] Ran `terraform fmt -check -recursive` (All HCL files properly formatted)
- [ ] Ran `terraform init -backend=false` & `terraform validate` inside target environment directory
- [ ] Ran local security scanner (`tfsec` / `checkov` / `tflint`)
- [ ] Verified no plaintext secrets or credentials exist in `.tf` or `.tfvars` files
- [ ] Updated `README.md` or architecture documentation if required

---

## 📸 Local Verification Screenshots / Command Outputs
*(Paste terminal output of `terraform validate` and `tfsec` or screenshots here)*

```text
[Paste terraform validate / tfsec output here]
```

---

## 👨‍💻 Sr. DevOps Lead Reviewer Checklist (To be filled by Reviewer)
- [ ] Verified CI pipeline passes (`terraform fmt`, `terraform validate`, `tflint`, `tfsec`)
- [ ] Verified Key Vault integration handles secrets securely
- [ ] Approved resource naming and tagging conventions
- [ ] Approved branch merge into target branch
