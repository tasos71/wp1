output "rgname" {
  value = azurerm_resource_group.rg.name
}

output "vnetname" {
  value = azurerm_virtual_network.vnet.name
}

output "vnetid" {
  value = azurerm_virtual_network.vnet.id
}

output "nsgname" {
  value = azurerm_network_security_group.nsg.name
}

output "subnet1" {
  value = azurerm_virtual_network.vnet.subnet1.address_prefixes
}

output "subnet2" {
  value = azurerm_virtual_network.vnet.subnet2.address_prefixes
}

