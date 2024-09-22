terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
}

provider "azurerm" {

  features {}
  subscription_id = "65008410-3554-490e-8d48-54b2b065d97a"
}

# generate a random string (consisting of four characters)
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "random" {
  length  = 4
  upper   = false
  special = false
}

## Azure Storage Accounts requires a globally unique names
## https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview
## Create a File Storage Account 
resource "azurerm_storage_account" "storage" {
  name                     = "stor${random_string.random.id}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Premium"
  account_replication_type = "LRS"
  account_kind             = "FileStorage"

  network_rules {
    default_action         = "Deny"
  }
}

#resource "azurerm_storage_share" "FSShare" {
#  name                 = "fslogix"
#  storage_account_name = azurerm_storage_account.storage.name
#  depends_on           = [azurerm_storage_account.storage]
#  quota                = 100
#}

## Azure built-in roles
## https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles
#data "azurerm_role_definition" "storage_role" {
#  name = "Storage File Data SMB Share Contributor"
#}
#
#resource "azurerm_role_assignment" "af_role" {
#  scope              = azurerm_storage_account.storage.id
#  role_definition_id = data.azurerm_role_definition.storage_role.id
#  principal_id       = azuread_group.aad_group.id
#}