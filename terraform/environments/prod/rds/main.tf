module "postgres" {
  source                     = "../../../modules/rds"
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
  backend_bucket     = var.backend_bucket
  region             = var.region
  backend_path       = var.backend_path
}
