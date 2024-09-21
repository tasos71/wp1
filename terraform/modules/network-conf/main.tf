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

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.region
}

#resource "azurerm_network_security_group" "nsg" {
#  name                = "${azurerm_resource_group.rg.name}-SecurityGroup1"
#  location            = azurerm_resource_group.rg.location
#  resource_group_name = azurerm_resource_group.rg.name
#
#  security_rule {
#    name                       = "AllowSMBOutboundToEU"
#    priority                   = 100
#    direction                  = "Outbound"
#    access                     = "Allow"
#    protocol                   = "Tcp"
#    source_port_range          = "*"
#    destination_port_range     = "445"
#    source_address_prefix      = ""
#    destination_address_prefix = "*"
#    description                = "Allow SMB outbound to EU file server"
#  }

resource "azurerm_virtual_network" "vnet" {
  name                = "${azurerm_resource_group.rg.name}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.main_cidr]

  subnet {
    name             = "${azurerm_resource_group.rg.name}-subnet1"
    address_prefixes = [var.subnet1]
  }

  subnet {
    name             = "${azurerm_resource_group.rg.name}-subnet2"
    address_prefixes = [var.subnet2]
    #security_group   = azurerm_network_security_group.example.id
  }
}