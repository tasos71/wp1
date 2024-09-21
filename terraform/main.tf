module "us" {
  source = "./environments/eu-region"
}

module "eu" {
  source = "./environments/us-region"
}
