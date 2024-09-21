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

resource "azurerm_network_security_rule" "sec-rule" {
    name                        = var.name
    priority                    = var.priority
    direction                   = var.direction
    access                      = var.access
    protocol                    = var.protocol
    source_port_range           = var.source_port_range
    destination_port_range      = var.destination_port_range
    source_address_prefix       = var.source_address_prefix
    destination_address_prefix  = var.destination_address_prefix
    description                 = var.description
    resource_group_name         = var.resource_group_name
    network_security_group_name = var.network_security_group_name
}