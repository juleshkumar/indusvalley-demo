
output "load_balancer_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.load_balancer.load_balancer_dns_name
}

output "security_groups" {
  value = module.load_balancer.lb_security_group
}


output "lb_arn" {
  value = module.load_balancer.lb_arn
}

output "lb_target_arn" {
  value = module.load_balancer.lb_target_arn
}