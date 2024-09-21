#terraform {
#  required_providers {
#    azurerm = {
#      source = "hashicorp/azurerm"
#      version = "~>4.0"
#    }
#  }
#}
#
#provider "azurerm" {
#
#  features {}
#  subscription_id = "65008410-3554-490e-8d48-54b2b065d97a"
#}
#
#resource "azurerm_network_security_rule" "sec-rule" {
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
#    resource_group_name         = azurerm_resource_group.example.name
#    network_security_group_name = azurerm_network_security_group.example.name
#}