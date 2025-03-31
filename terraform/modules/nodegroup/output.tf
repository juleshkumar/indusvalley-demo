output "node_role_arn" {
  value = aws_iam_role.node.arn
}

output "eks_key_pair_name" {
  value = aws_key_pair.eks.key_name
}

output "efs_mount_target_sg_id" {
  value = aws_security_group.efs_mount_target_sg.id
}

output "node_group_decimal0" {
  value = {
    node_group_name = aws_eks_node_group.decimal0[*].node_group_name
    instance_types  = aws_eks_node_group.decimal0[*].instance_types
    capacity_type   = aws_eks_node_group.decimal0[*].capacity_type
    disk_size       = aws_eks_node_group.decimal0[*].disk_size
  }
}

output "node_group_decimal1" {
  value = {
    node_group_name = aws_eks_node_group.decimal1[*].node_group_name
    instance_types  = aws_eks_node_group.decimal1[*].instance_types
    capacity_type   = aws_eks_node_group.decimal1[*].capacity_type
    disk_size       = aws_eks_node_group.decimal1[*].disk_size
  }
}

output "node_ca_policy_arn" {
  value = aws_iam_policy.node_ca.arn
}
