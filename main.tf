# Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.52.0"
    }
  }
   backend "azurerm" {
    resource_group_name  = "rg-terraformstate"
    storage_account_name = "terrastatestg22032021"
    container_name       = "terraform"
    key                  = "dev.terraform.tfstate"
  }
}

#Azure provider
provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "tf-keyvault"
  location = "WestUS2"
}

resource "azurerm_key_vault" "vault" {
  name                       = "keyvault22032021"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "create",
      "get",
    ]

    secret_permissions = [
      "set",
      "get",
      "delete",
      "purge",
      "recover",
      "List"
    ]
  }
}

resource "azurerm_key_vault_secret" "secret" {
  name         = "secret-terraform"
  value        = "xxxxx"
  key_vault_id = azurerm_key_vault.vault.id
}