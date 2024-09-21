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

resource "azurerm_virtual_network_peering" "spoke-hub-peer" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.virtual_network_name
  remote_virtual_network_id    = var.remote_virtual_network_id

  allow_virtual_network_access = true
}