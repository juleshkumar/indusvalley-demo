terraform {
  backend "s3" {
    bucket     = "terraform-testing-backend-bucket"
    key        = "prod/backend/vpc"
    region     = "ap-south-1"
  }
}
