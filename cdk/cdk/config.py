# cdk/config.py

from aws_cdk import Fn

# VPC Configuration
VPC_CONFIG = {
    "vpc_cidr": "10.0.0.0/16",
    "public_subnet_cidrs": ["10.0.1.0/24", "10.0.2.0/24"],
    "private_app_subnet_cidrs": ["10.0.3.0/24", "10.0.4.0/24"],
    "db_subnet_cidrs": ["10.0.5.0/24", "10.0.6.0/24"],
    "availability_zones": ["ap-south-1a", "ap-south-1b"],
    "environment": "uat"
}

# Dynamically import VPC ID and Public Subnet 1 ID from VpcConstruct
vpc_id = Fn.import_value("DemoVpcConstruct-VPCID")  # Replace with your export name
public_subnet1_id = Fn.import_value("DemoVpcConstruct-PublicSubnet1")  # Replace with your export name

# EC2 Configuration
EC2_CONFIG = {
    "vpc_id": vpc_id,  # Use the imported VPC ID
    "subnet_id": public_subnet1_id,  # Use the imported Public Subnet 1 ID
    "availability_zone": "ap-south-1a",  # Replace with your AZ
    "ssh_key_name": "demo-keypair",  # Replace with your key pair name
    "instance_ami_id": "ami-0e91af172501f523f",  # Replace with your AMI ID
    "instance_type": "t2.micro",  # Replace with your instance type
    "security_group_name": "demo-ec2-sg",  # Replace with your SG name
    "app_name": "demo",  # Replace with your app name
    "cluster_name": "NA",  # Replace with your cluster name
    "environment_name": "UAT",  # Replace with your environment name
    "role_tag": "uat-EC2Role",  # Replace with your role tag
    "remark": "demo-client",  # Replace with your remark
    "root_volume_size": 10,  # Replace with your root volume size
    "instance_name": "new-demo-ec2-test",  # Replace with your instance name
}