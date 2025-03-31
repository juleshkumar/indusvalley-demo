module "ec2_linux" {
  source            = "../../../modules/ec2_linux"
  ami               = var.ami
  public_key_file   = var.public_key_file
  ec2_instance_type = var.ec2_instance_type
  ec2_key_name      = var.ec2_key_name
  js_user           = var.js_user
  linux_tags = var.linux_tags
  backend_bucket     = var.backend_bucket
  region             = var.region
  backend_path       = var.backend_path
}
