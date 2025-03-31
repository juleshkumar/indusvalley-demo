terraform {
  backend "s3" {
    bucket     = "terraform-testing-backend-bucket"
    key        = "dev/backend/ec2-mssql"
    region     = "ap-south-1"
  }
}
