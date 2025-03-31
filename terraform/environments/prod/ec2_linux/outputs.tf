output "private_ip" {
  description = "Private IP of instance"
  value       = module.ec2_linux.private_ip
}

output "private_dns" {
  description = "Private DNS of instance"
  value       = module.ec2_linux.private_dns
}

output "instance_id" {
  description = "ID of the instance"
  value       = module.ec2_linux.id
}

output "instance_arn" {
  description = "ARN of the instance"
  value       = module.ec2_linux.arn
}

output "instance_profile_name" {
  description = "Name of the IAM instance profile"
  value       = module.ec2_linux.iam_instance_profile_name
}

output "instance_security_group_id" {
  description = "ID of the instance security group"
  value       = module.ec2_linux.security_group_id
}