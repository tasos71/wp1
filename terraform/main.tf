module "eu-conf" {
  source = "./environments/eu-region"
}

module "us-conf" {
  source = "./environments/us-region"
}

module "eu-us-peerirg" {
  source                       = "./modules/network-peerirg"
  #name                         = "${module.eu-network.resource_group}-to-us-peering"
  #resource_group_name          = "${module.us-network.resource_group}"
  #virtual_network_name         = "${module.eu-conf.module.eu-network.name}"
  remote_virtual_network_id    = "${module.eu-conf.module.eu-network.vnetid}"
}

