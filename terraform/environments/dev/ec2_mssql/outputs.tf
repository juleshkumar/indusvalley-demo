output "private_ip" {
  description = "Private IP of instance"
  value       = module.ec2_mssql.private_ip
}

output "private_dns" {
  description = "Private DNS of instance"
  value       = module.ec2_mssql.private_dns
}

output "instance_id" {
  description = "ID of the instance"
  value       = module.ec2_mssql.id
}

output "instance_arn" {
  description = "ARN of the instance"
  value       = module.ec2_mssql.arn
}

output "instance_profile_name" {
  description = "Name of the IAM instance profile"
  value       = module.ec2_mssql.iam_instance_profile_name
}

output "instance_security_group_id" {
  description = "ID of the instance security group"
  value       = module.ec2_mssql.security_group_id
}