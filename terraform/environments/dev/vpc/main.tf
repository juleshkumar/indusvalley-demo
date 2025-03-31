module "vpc" {
  source         = "../../../modules/vpc"
  vpc_cidr       = var.vpc_cidr
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  vpc_tags       = var.vpc_tags
  igw_tags       = var.igw_tags
  cluster-name   = var.cluster-name
#  azs            = var.azs
  environment    = var.environment
  security_group = var.security_group
}
