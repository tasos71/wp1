output "rgname" {
  value = azurerm_resource_group.rg.name
}

output "vnetname" {
  value = azurerm_virtual_network.vnet.name
}

output "vnetid" {
  value = azurerm_virtual_network.vnet.id
}