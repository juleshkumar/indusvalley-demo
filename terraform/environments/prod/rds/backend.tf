terraform {
  backend "s3" {
    bucket     = "terraform-testing-backend-bucket"
    key        = "prod/backend/rds"
    region     = "ap-south-1"
  }
}

