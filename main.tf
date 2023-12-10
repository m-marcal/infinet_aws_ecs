provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "./modules/network"
  project_name = var.project_name
}

module "ecs" {
  depends_on = [ module.network ]
  source = "./modules/ecs"

  project_name = var.project_name
  priv_subnet_ids = module.network.private_subnets
  pub_subnet_ids = module.network.public_subnets
  vpc_id = module.network.vpc_id
  TIMDb_API_KEY = var.TIMDb_API_KEY
}