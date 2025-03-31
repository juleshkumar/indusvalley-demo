resource "aws_eks_addon" "coredns" {
  cluster_name                = var.cluster-name
  addon_name                  = "coredns"
  addon_version               = "v1.10.1-eksbuild.4"
  resolve_conflicts_on_update = "PRESERVE" # or "OVERRIDE" depending on your preference
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = var.cluster-name
  addon_name                  = "kube-proxy"
  addon_version               = "v1.28.2-eksbuild.2"
  resolve_conflicts_on_update = "PRESERVE" # or "OVERRIDE" depending on your preference
}

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name                = var.cluster-name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = "v1.30.0-eksbuild.1"
  resolve_conflicts_on_update = "PRESERVE" # or "OVERRIDE" depending on your preference
}

resource "aws_eks_addon" "efs_csi_driver" {
  cluster_name                = var.cluster-name
  addon_name                  = "aws-efs-csi-driver"
  addon_version               = "v2.0.2-eksbuild.1"
  resolve_conflicts_on_update = "PRESERVE" # or "OVERRIDE" depending on your preference
}
resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = var.cluster-name
  addon_name                  = "vpc-cni"
  addon_version               = "v1.15.1-eksbuild.1"
  resolve_conflicts_on_update = "PRESERVE" # or "OVERRIDE" depending on your preference
}
