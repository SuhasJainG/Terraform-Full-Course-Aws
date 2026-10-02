module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr
  name_prefix     = var.cluster_name
}

module "iam" {
  source = "./modules/iam"
  cluster_name = var.cluster_name
  name_prefix = var.cluster_name
}