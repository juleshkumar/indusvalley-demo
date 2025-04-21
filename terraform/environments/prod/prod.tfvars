region = "ap-south-1"

backend_path = "prod"

backend_bucket = "terraform-testing-backend-bucket"

#VPC variables

vpc_cidr = "10.0.0.0/16"

public_subnet_1_cidr = "10.0.0.0/24"

public_subnet_2_cidr = "10.0.1.0/24"

private_subnet_1_cidr = "10.0.2.0/24"

private_subnet_2_cidr = "10.0.3.0/24"

vpc_tags = {Name: "test-prod-vpc",Environment = "prod"}

igw_tags = {Name: "test-prod-igw",Environment = "prod"}

environment = "prod"

security_group = "vpc-sg"

#ALB variables

load_balancer_name = "test-prod-ALB"

internal = false

load_balancer_type = "application"

lb_security_group = "prod-load-balancer-sg"

target-group-name = "tg-prod-sg-lb"

protocol = "HTTP"

lb-port = 30023

from_ports = 443

to_ports = 443

security-group-cidr = "0.0.0.0/0"

lb_tags = {Name: "test-prod-ALB",Environment = "prod"}

#EC2-MSSQL variables

mssql_ami = "ami-029f38f0f7288a049"

mssql_ec2_instance_type = "r5.xlarge"

ec2_mssql_tags = {Name: "test-prod-mssql",Environment = "prod"}

mssql_ec2_key_name = "test-keypair"

#EC2-Linux vairbales

ami = "ami-08fe5144e4659a3b3"

ec2_instance_type = "t2.micro"

linux_tags = {Name: "test-prod-linux",Environment = "prod"}

ec2_key_name = "test-keypair"

#EKS vairbales

k8s_version = "1.31"

cluster-name =  "test-prod-eks-cluster"

cloudwatch_logs = false

cluster-autoscaler = false

eks_tags = {Name: "test-prod-eks-cluster",Environment = "prod"}

#RDS vairbales

rds_db_instance_identifier = "test-prod-db-tech"

rds_database_name = "test_prod_database"

database_password = "Qwerty#789"

database_user = "dbadmin"

major_version = "12"

engine_version = "12.18"

rds_db_security_group = "test-prod-sg"

rds_db_instance_type = "db.m6g.large"

rds_db_allocated_storage = "20"

rds_port = 5432

rds_tags  = {Name: "test-prod-rds",Environment = "prod"}






















































