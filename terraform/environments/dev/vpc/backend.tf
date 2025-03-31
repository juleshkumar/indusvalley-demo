terraform {
  backend "s3" {
    bucket     = "terraform-testing-backend-bucket"
    key        = "dev/backend/vpc"
    region     = "ap-south-1"
  }
}
