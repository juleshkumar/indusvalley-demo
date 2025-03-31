output "node_role_arn" {
  value = module.nodegroup.node_role_arn
}

output "eks_key_pair_name" {
  value = module.nodegroup.eks_key_pair_name
}

output "efs_mount_target_sg_id" {
  value = module.nodegroup.efs_mount_target_sg_id
}

output "node_group_decimal0" {
  value = module.nodegroup.node_group_decimal0
}

output "node_group_decimal1" {
  value = module.nodegroup.node_group_decimal1
}

output "node_ca_policy_arn" {
  value = module.nodegroup.node_ca_policy_arn
}
