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
  subscription_id = var.az_sub_id
}
