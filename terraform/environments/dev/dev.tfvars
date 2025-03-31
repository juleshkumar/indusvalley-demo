region = "ap-south-1"

backend_path = "dev"

backend_bucket = "terraform-testing-backend-bucket"

#VPC variables

vpc_cidr = "10.0.0.0/16"

public_subnet_1_cidr = "10.0.0.0/24"

public_subnet_2_cidr = "10.0.1.0/24"

private_subnet_1_cidr = "10.0.2.0/24"

private_subnet_2_cidr = "10.0.3.0/24"

vpc_tags = {Name: "test-dev-vpc",Environment = "dev"}

igw_tags = {Name: "test-dev-igw",Environment = "dev"}

environment = "dev"

security_group = "vpc-sg"

#ALB variables

load_balancer_name = "test-dev-ALB"

internal = false

load_balancer_type = "application"

lb_security_group = "dev-load-balancer-sg"

target-group-name = "tg-dev-sg-lb"

protocol = "HTTP"

lb-port = 30023

from_ports = 443

to_ports = 443

security-group-cidr = "0.0.0.0/0"

lb_tags = {Name: "test-dev-ALB",Environment = "dev"}

#EC2-MSSQL variables

mssql_public_key_file = "test-dev" #Need to remove this variable

mssql_ami = "ami-029f38f0f7288a049"

mssql_ec2_instance_type = "r5.xlarge"

mssql_js_user = "test-dev-user"

ec2_mssql_tags = {Name: "test-dev-mssql",Environment = "dev"}

mssql_ec2_key_name = "test-keypair"

#EC2-Linux vairbales

public_key_file = "test-dev" #Need to remove this variable

ami = "ami-08fe5144e4659a3b3"

ec2_instance_type = "t2.micro"

js_user = "test-dev-user"

linux_tags = {Name: "test-dev-linux",Environment = "dev"}

ec2_key_name = "test-keypair"

#EKS vairbales

k8s_version = "1.31"

cluster-name =  "test-dev-eks-cluster"

cloudwatch_logs = false

cluster-autoscaler = false

eks_tags = {Name: "test-dev-eks-cluster",Environment = "dev"}

#RDS vairbales

rds_db_instance_identifier = "test-dev-db-tech"

rds_database_name = "test_dev_database"

database_password = "Qwerty#789"

database_user = "dbadmin"

major_version = "12"

engine_version = "12.18"

rds_db_security_group = "test-dev-sg"

rds_db_instance_type = "db.m6g.large"

rds_db_allocated_storage = "20"

rds_port = 5432

rds_tags  = {Name: "test-dev-rds",Environment = "dev"}






















































