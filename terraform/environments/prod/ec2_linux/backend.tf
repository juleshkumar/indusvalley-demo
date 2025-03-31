terraform {
  backend "s3" {
    bucket     = "terraform-testing-backend-bucket"
    key        = "prod/backend/ec2-linux"
    region     = "ap-south-1"
  }
}
