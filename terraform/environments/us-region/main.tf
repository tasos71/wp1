module "us-network" {
  source            = "../../modules/network-conf"
  resource_group    = "test-tech_task-wp01--rg_us_west"
  region            = "westus"
  main_cidr         = "10.4.0.0/16"
  subnet1           = "10.4.1.0/24"
  subnet2           = "10.4.2.0/24"
}

#module "us-eu-peerirg" {
#  source = "./modules/network-peerirg"
#  var.name
#  resource_group_name          = module.eu-conf.module.eu-network.azurerm_resource_group.rg
#  virtual_network_name         = module.us-conf.module.us-network.azurerm_virtual_network.vnet
#  remote_virtual_network_id    = var.remote_virtual_network_id
#}