module "us-network" {
  source            = "../../modules/network-conf"
  resource_group    = "tasos-tech_task-wp01--rg_us_west"
  region            = "westus"
  main_cidr         = "10.4.0.0/16"
  subnet1           = "10.4.1.0/24"
  subnet2           = "10.4.2.0/24"
}