module "vpc" {
  source         = "../../modules/vpc"
  vpc_cidr       = var.vpc_cidr
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  vpc_tags       = var.vpc_tags
  igw_tags       = var.igw_tags
  cluster-name   = var.cluster-name
  environment    = var.environment
  security_group = var.security_group
}

module "load_balancer" {
  source                 = "../../modules/load_balancer"
  load_balancer_name     = var.load_balancer_name
  internal               = var.internal
  load_balancer_type     = var.load_balancer_type
  lb_security_group      = var.lb_security_group
  lb-port                = var.lb-port
  from_ports             = var.from_ports
  to_ports               = var.to_ports
  protocol               = var.protocol
  security-group-cidr    = var.security-group-cidr
  target-group-name      = var.target-group-name
  lb_tags = var.lb_tags
  lb_vpc_id              = module.vpc.vpc_id
  lb_subnets             = module.vpc.public_subnet_ids
  depends_on = [module.vpc]
}

module "ec2_mssql" {
  source            = "../../modules/ec2_mssql"
  mssql_ami               = var.mssql_ami
  mssql_ec2_instance_type = var.mssql_ec2_instance_type
  mssql_ec2_key_name      = var.mssql_ec2_key_name
  ec2_mssql_tags = var.ec2_mssql_tags
  mssql_subnet = module.vpc.private_subnet_ids[0]
  mssql_vpc_id = module.vpc.vpc_id
  depends_on = [module.vpc]
}

module "ec2_linux" {
  source            = "../../modules/ec2_linux"
  ami               = var.ami
  ec2_instance_type = var.ec2_instance_type
  ec2_key_name      = var.ec2_key_name
  linux_tags = var.linux_tags
  linux_vpc_id = module.vpc.vpc_id
  linux_subnet = module.vpc.private_subnet_ids[0]
  depends_on = [module.vpc]
}

module "eks" {
  source                         = "../../modules/eks"
  cloudwatch_logs                = var.cloudwatch_logs
  cluster-autoscaler             = var.cluster-autoscaler
  cluster-name                   = var.cluster-name
  k8s_version                    = var.k8s_version
  eks_tags = var.eks_tags
  eks_vpc_cidr = module.vpc.vpc_cidr_block
  eks_subnets = module.vpc.private_subnet_ids
  eks_vpc_id = module.vpc.vpc_id
  depends_on = [module.vpc]
}

module "postgres" {
  source                     = "../../modules/rds"
  major_version              = var.major_version
  engine_version             = var.engine_version
  #rds__db_cidr_range         = var.rds__db_cidr_range
  rds_database_name          = var.rds_database_name
  rds_db_allocated_storage   = var.rds_db_allocated_storage
  rds_db_instance_identifier = var.rds_db_instance_identifier
  rds_db_instance_type       = var.rds_db_instance_type
  rds_db_security_group      = var.rds_db_security_group
  database_password          = var.database_password
  database_user              = var.database_user
  rds_tags = var.rds_tags
  rds_port                   = var.rds_port
  rds_vpc_id = module.vpc.vpc_id
  rds_vpc_cidr = module.vpc.vpc_cidr_block
  rds_subnets = module.vpc.private_subnet_ids
  depends_on = [module.vpc]
}