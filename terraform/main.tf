module "eu-conf" {
  source = "./environments/eu-region"
}

module "us-conf" {
  source = "./environments/us-region"
}

module "eu-us-peerirg" {
  source                       = "./modules/network-peerirg"
  name                         = "${module.eu-conf.rgname}-to-us-peering"
  resource_group_name          = "${module.eu-conf.rgname}"
  virtual_network_name         = "${module.eu-conf.vnetname}"
  remote_virtual_network_id    = "${module.eu-conf.vnetid}"
}

