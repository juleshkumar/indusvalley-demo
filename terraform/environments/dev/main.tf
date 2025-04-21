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
  #depends_on = [module.vpc]
}

module "kms" {
  source       = "../../modules/kms"
  kms_key_name = var.kms_key_name
  kms_tags = var.kms_tags
  account_id = var.account_id
}


module "ec2_mssql" {
  source            = "../../modules/ec2_mssql"
  mssql_ami               = var.mssql_ami
  mssql_ec2_instance_type = var.mssql_ec2_instance_type
  mssql_ec2_key_name      = var.mssql_ec2_key_name
  ec2_mssql_tags = var.ec2_mssql_tags
  mssql_subnet = module.vpc.private_subnet_ids[0]
  mssql_vpc_id = module.vpc.vpc_id
  #depends_on = [module.vpc]
}

module "ec2_linux" {
  source            = "../../modules/ec2_linux"
  ami               = var.ami
  ec2_instance_type = var.ec2_instance_type
  ec2_key_name      = var.ec2_key_name
  linux_tags = var.linux_tags
  linux_vpc_id = module.vpc.vpc_id
  linux_subnet = module.vpc.private_subnet_ids[0]
  #depends_on = [module.vpc]
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
  eks_kms_arn = module.kms.key_arn
  eks_vpc_id = module.vpc.vpc_id
  #depends_on = [module.vpc]
}

module "nodegroup" {
  source                           = "../../modules/nodegroup"
  cloudwatch_logs                  = var.cloudwatch_logs
  cluster-name                     = var.cluster-name
  environment                      = var.environment
  ec2_root_volume_size = var.ec2_root_volume_size
  k8s_version = var.k8s_version
  node_groups_test              = var.node_groups_test
  node_groups_test_tt           = var.node_groups_test_tt
  key_name = var.key_name
  app_env_type = var.app_env_type
  project = var.project
  eks_cluster_id = module.eks.eks_cluster_id
  eks_cluster_sg_id = module.eks.eks_cluster_security_group_id
  ng_vpc_id = module.vpc.vpc_id
  ng_subnets = module.vpc.private_subnet_ids
  ng_kms_arn = module.kms.key_arn
  #depends_on = [module.vpc, module.eks]
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
  database_user              = var.database_user
  rds_tags = var.rds_tags
  rds_port                   = var.rds_port
  rds_kms_arn = module.kms.key_arn
  rds_vpc_id = module.vpc.vpc_id
  rds_vpc_cidr = module.vpc.vpc_cidr_block
  rds_subnets = module.vpc.private_subnet_ids
  #depends_on = [module.vpc]
}

module "elasticache" {
  source               = "../../modules/elasticache"
  redis-cluster        = var.redis-cluster
  redis-engine         = var.redis-engine
  redis-engine-version = var.redis-engine-version
  redis-node-type      = var.redis-node-type
  #  num-cache-nodes        = var.num-cache-nodes
  parameter-group-family  = var.parameter-group-family
  replication-id          = var.replication-id
  num-node-groups         = var.num-node-groups
  replicas-per-node-group = var.replicas-per-node-group
  elasticache_tags = var.elasticache_tags
  redis-user-id           = var.redis-user-id
  redis-user-name         = var.redis-user-name
  redis_port              = var.redis_port
  redis-user-group   = var.redis-user-group
  environment                      = var.environment
  redis_rest_encryption = var.redis_rest_encryption
  redis_transit_encryption = var.redis_transit_encryption
  redis_kms_arn = module.kms.key_arn
  redis_subnets = module.vpc.private_subnet_ids
  redis_vpc_cidr_block = module.vpc.vpc_cidr_block
  redis_vpc_id = module.vpc.vpc_id
  #depends_on = [module.vpc]
}

module "rabbit_mq" {
  source               = "../../modules/rabbit_mq"
  broker_name = var.broker_name
  mq_engine_version = var.mq_engine_version
  host_instance_type = var.host_instance_type
  deployment_mode = var.deployment_mode
  publicly_accessible = var.publicly_accessible
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately = var.apply_immediately
  storage_type = var.storage_type
  mq_subnet_ids = [module.vpc.private_subnet_ids[0]]
  mq_vpc_id = module.vpc.vpc_id
  mq_security_group_name = var.mq_security_group_name
  mq_security_group_description = var.mq_security_group_description
  mq_port = var.mq_port
  mq_allowed_cidrs = var.mq_allowed_cidrs
  mq_username = var.mq_username
  console_access = var.console_access
  user_groups = var.user_groups
  maintenance_day = var.maintenance_day
  maintenance_time = var.maintenance_time
  maintenance_timezone = var.maintenance_timezone
  logs_general = var.logs_general
  mq_tags = var.mq_tags
}