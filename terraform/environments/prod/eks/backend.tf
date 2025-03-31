terraform {
  backend "s3" {
    bucket   = "terraform-testing-backend-bucket"
    key      = "prod/backend/eks"
    region   = "ap-south-1"
  }
}
