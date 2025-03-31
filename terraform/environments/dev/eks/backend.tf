terraform {
  backend "s3" {
    bucket   = "terraform-testing-backend-bucket"
    key      = "dev/backend/eks"
    region   = "ap-south-1"
  }
}
