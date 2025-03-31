module "kms" {
  source       = "../../../modules/kms"
  kms_key_name = "eks-cluster-${var.kms_key_name}"
  kms_tags = var.kms_tags
}
