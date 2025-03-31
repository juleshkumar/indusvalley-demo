module "load_balancer" {
  source                 = "../../../modules/load_balancer"
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
  region                 = var.region
  backend_bucket         = var.backend_bucket
  backend_path           = var.backend_path
}
