module "eu-network" {
  source            = "../../modules/network-conf"
  resource_group    = "tasos-tech_task-wp01--rg_eu_west"
  region            = "westeurope"
  main_cidr         = "10.5.0.0/16"
  subnet1           = "10.5.1.0/24"
  subnet2           = "10.5.2.0/24"
}

output "vnetid" {
  value = module.eu-network.vnet.id
}