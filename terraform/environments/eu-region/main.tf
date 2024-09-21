module "eu-network" {
  source            = "../../modules/network-conf"
  resource_group    = "tasos-tech_task-wp01--rg_eu_west"
  region            = "westeurope"
  main_cidr         = "10.5.0.0/16"
  subnet1           = "10.5.1.0/24"
  subnet2           = "10.5.2.0/24"
}

module "eu-us-peerirg" {
  source                       = "../../modules/network-peerirg"
  #name                         = "${module.eu-network.resource_group}-to-us-peering"
  #resource_group_name          = "${module.us-network.resource_group}"
  #virtual_network_name         = "${module.eu-conf.module.eu-network.name}"
  remote_virtual_network_id    = "${module.eu-network.vnetid}"
}