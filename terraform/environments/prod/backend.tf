terraform {
  backend "s3" {
    bucket     = "terraform-testing-backend-bucket-julesh"
    key        = "prod/backend/test"
    region     = "ap-south-1"
  }
}

