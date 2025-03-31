# EKS Cluster Outputs
output "eks_cluster_id" {
  description = "The name of the cluster"
  value       = module.eks.eks_cluster_id
}

output "eks_cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.eks.eks_cluster_arn
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the Kubernetes API server"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_cluster_version" {
  description = "The Kubernetes server version of the cluster"
  value       = module.eks.eks_cluster_version
}

output "eks_cluster_security_group_id" {
  description = "The ID of the additional EKS cluster security group"
  value       = module.eks.eks_cluster_security_group_id
}

output "eks_cluster_security_group_arn" {
  description = "The ARN of the additional EKS cluster security group"
  value       = module.eks.eks_cluster_security_group_arn
}

output "eks_cluster_certificate_authority" {
  description = "The Kubernetes cluster certificate authority data"
  value       = module.eks.eks_cluster_certificate_authority
}

output "eks_oidc_provider_arn" {
  description = "The ARN of the OIDC Provider"
  value       = module.eks.eks_oidc_provider_arn
}

output "eks_oidc_provider_url" {
  description = "The URL of the OIDC Provider"
  value       = module.eks.eks_oidc_provider_url
}