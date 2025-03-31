terraform {
  backend "s3" {
    bucket     = var.backend_bucket
    key        = "${var.backend_path}/backend/elasticache"
    region     = var.region
  }
}

