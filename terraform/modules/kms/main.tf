resource "aws_kms_key" "kms" {
  description              = "eks-cluster-${var.kms_key_name}"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  key_usage                = "ENCRYPT_DECRYPT"
  enable_key_rotation      = "true"
  multi_region             = "false"
  tags = var.kms_tags
}

resource "aws_kms_alias" "key_alias" {
  name          = "alias/${var.kms_key_name}-alias"
  target_key_id = aws_kms_key.kms.key_id
}

