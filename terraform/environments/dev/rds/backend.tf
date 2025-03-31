terraform {
  backend "s3" {
    bucket     = "terraform-testing-backend-bucket"
    key        = "dev/backend/rds"
    region     = "ap-south-1"
  }
}

