module "eu-network" {
  source            = "../../modules/network-conf"
  resource_group    = "tasos-tech_task-wp01--rg_eu_west"
  region            = "westeurope"
  main_cidr         = "10.5.0.0/16"
  subnet1           = "10.5.1.0/24"
  subnet2           = "10.5.2.0/24"
}

module "eu-sec-rule-1" {
  source                      = "../../modules/sec-rules"
  name                        = "AllowSMBInboundFromUS"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = 445
  source_address_prefix       = module.eu-network.subnet1
  destination_address_prefix  = "*"
  description                 = "Allow SMB inbound from US Subnet 1"
  resource_group_name         = "${module.eu-network.rgname}"
  network_security_group_name = "${module.eu-network.nsgname}"
}