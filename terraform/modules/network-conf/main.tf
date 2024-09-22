resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.region
}
resource "azurerm_network_security_group" "nsg" {
  name                = "${azurerm_resource_group.rg.name}-NSG"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
resource "azurerm_virtual_network" "vnet" {
  name                = "${azurerm_resource_group.rg.name}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.main_cidr]
}
resource "azurerm_subnet" "subnet1" {
  name                 = "${azurerm_resource_group.rg.name}-subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet1]
}
resource "azurerm_subnet" "subnet2" {
  name                 = "${azurerm_resource_group.rg.name}-subnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name    
  address_prefixes     = [var.subnet2]
}