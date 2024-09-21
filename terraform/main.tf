module "eu-conf" {
  source = "./environments/eu-region"
}

module "us-conf" {
  source = "./environments/us-region"
}

module "eu-us-peerirg" {
  source                       = "./modules/network-peerirg"
  name                         = "${module.eu-conf.module.eu-network.name}-to-us-peering"
  #resource_group_name          = "${module.eu-conf.module.us-network.name}"
  #virtual_network_name         = "${module.eu-conf.module.eu-network.name}"
  #remote_virtual_network_id    = "${module.us-conf.module.us-network.id}"
}

#module "us-eu-peerirg" {
#  source = "./modules/network-peerirg"
#  var.name
#  resource_group_name          = module.eu-conf.module.eu-network.azurerm_resource_group.rg
#  virtual_network_name         = module.us-conf.module.us-network.azurerm_virtual_network.vnet
#  remote_virtual_network_id    = var.remote_virtual_network_id
#}
