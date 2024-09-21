module "eu-network" {
  source            = "../../modules/network-conf"
  resource_group    = "tasos-tech_task-wp01--rg_eu_west"
  region            = "westeurope"
}