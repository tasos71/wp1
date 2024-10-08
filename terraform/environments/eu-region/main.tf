module "eu-network" {
  source            = "../../modules/network-conf"
  resource_group    = "test-tech_task-wp01--rg_eu_west"
  region            = "westeurope"
  main_cidr         = "10.5.0.0/16"
  subnet1           = "10.5.1.0/24"
  subnet2           = "10.5.2.0/24"
}

resource "azurerm_network_security_group" "nsg-fileserver" {
  name                = "${module.eu-network.rgname}-NSG-fileserver"
  location            = "westeurope"
  resource_group_name = module.eu-network.rgname
}

resource "azurerm_network_security_group" "nsg-admin" {
  name                = "${module.eu-network.rgname}-NSG-Admin"
  location            = "westeurope"
  resource_group_name = module.eu-network.rgname
}

module "azure-file-server" {
  source              = "../../modules/azure-file-server"
  name                = "euwp1storagetest102"
  location            = "westeurope"
  resource_group_name = module.eu-network.rgname
}