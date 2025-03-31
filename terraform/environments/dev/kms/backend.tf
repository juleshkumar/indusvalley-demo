terraform {
  backend "s3" {
    bucket     = var.backend_bucket
    key        = "${var.backend_path}/backend/kms"
    region     = var.region
  }
}

