terraform {
  backend "s3" {
    bucket   = var.backend_bucket
    key      = "${var.backend_path}/backend/nodegroups"
    region   = var.region
  }
}
