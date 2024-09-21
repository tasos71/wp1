module "us-network" {
  source            = "../../modules/network-conf"
  resource_group    = "tasos-tech_task-wp01--rg_us_west"
  region            = "westus"
}