module "ec2_mssql" {
  source            = "../../../modules/ec2_mssql"
  mssql_ami               = var.mssql_ami
  mssql_public_key_file   = var.mssql_public_key_file
  mssql_ec2_instance_type = var.mssql_ec2_instance_type
  mssql_ec2_key_name      = var.mssql_ec2_key_name
  mssql_js_user           = var.mssql_js_user
  ec2_mssql_tags = var.ec2_mssql_tags
  backend_bucket     = var.backend_bucket
  region             = var.region
  backend_path       = var.backend_path
}
