terraform {
  backend "azurerm" {
    resource_group_name  = "preprod-tfstate-rg"
    storage_account_name = "sttfstateprod"
    container_name       = "tfstate"
    key                  = "preprod.terraform.tfstate"
  }
}
