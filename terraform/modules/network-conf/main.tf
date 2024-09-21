resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.region
}

#resource "azurerm_network_security_group" "example" {
#  name                = "acceptanceTestSecurityGroup1"
#  location            = azurerm_resource_group.example.location
#  resource_group_name = azurerm_resource_group.example.name
#
#  security_rule {
#    name                       = "test123"
#    priority                   = 100
#    direction                  = "Inbound"
#    access                     = "Allow"
#    protocol                   = "Tcp"
#    source_port_range          = "*"
#    destination_port_range     = "*"
#    source_address_prefix      = "*"
#    destination_address_prefix = "*"
#  }
#
#
#resource "azurerm_virtual_network" "vnet-${var.region}" {
#  name                = "${var.region}-vnet"
#  location            = azurerm_resource_group.spoke-vnet-rg.location
#  resource_group_name = azurerm_resource_group.spoke-vnet-rg.name
#  address_space       = [var.main_cidr]
#
#  subnet {
#    name             = "subnet1"
#    address_prefixes = [var.subnet1]
#  }
#
#  subnet {
#    name             = "subnet2"
#    address_prefixes = [var.subnet2]
#    security_group   = azurerm_network_security_group.example.id
#  }
#}
#
#
#resource "azurerm_virtual_network_peering" "spoke-hub-peer" {
#  name                      = "${var.vpc_name}-spoke-hub-peer"
#  resource_group_name       = azurerm_resource_group.spoke-vnet-rg.name
#  virtual_network_name      = azurerm_virtual_network.spoke-vnet.name
#  remote_virtual_network_id = var.remote_virtual_network_id
#
#  allow_virtual_network_access = true
#  allow_forwarded_traffic = true
#  allow_gateway_transit   = false
#  use_remote_gateways     = true
#
#}
#
#resource "azurerm_virtual_network_peering" "hub-spoke-peer" {
#  name                      = "${var.vpc_name}-hub-spoke-peer"
#  resource_group_name       = var.main_rg
#  virtual_network_name      = var.hub_vnet
#  remote_virtual_network_id = azurerm_virtual_network.spoke-vnet.id
#  allow_virtual_network_access = true
#  allow_forwarded_traffic   = true
#  allow_gateway_transit     = true
#  use_remote_gateways       = false
#}