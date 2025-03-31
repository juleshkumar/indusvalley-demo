terraform {
  backend "s3" {
    bucket     = "terraform-testing-backend-bucket"
    key        = "dev/backend/load_balancer"
    region     = "ap-south-1"
  }
}
