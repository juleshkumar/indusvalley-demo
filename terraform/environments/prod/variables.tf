####COMMON########

variable "region" {
  type = string
}

variable "backend_bucket" {
  type = string
}

variable "backend_path" {
  description = "The name of the cluster"
  type        = string
}

####VPC#####

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
}

variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = map(string)

}

variable "igw_tags" {
  description = "Tags for the IGW"
  type        = map(string)
}

variable "environment" {
  type        = string
  description = "environment for vpc"
}

variable "security_group" {
  type        = string
  description = "vpc security group"
}

#####ALB########

variable "load_balancer_name" {
  type        = string
  description = "Name of the load balancer"
}

variable "internal" {
  description = "Whether the load balancer is internal or not"
  type        = bool
}

variable "load_balancer_type" {
  description = "Type of load balancer (e.g., application)"
  type        = string
}

variable "lb_security_group" {
  type        = string
  description = "load balancer security group"
}


variable "target-group-name" {
  type        = string
  description = "name of the target group"
}

variable "protocol" {
  type        = string
  description = "protocol type"
}

variable "lb-port" {
  type        = number
  description = "ports"
}

variable "from_ports" {
  type        = number
  description = "from port to lb"
}

variable "to_ports" {
  type        = number
  description = "to port lb"
}

variable "security-group-cidr" {
  type        = string
  description = "cidr range of the security group"
}

variable "lb_tags" {
  type = map(string)
}

variable "lb_vpc_id" {
  type        = string
  description = "vpc id"
  default = ""
}

variable "lb_subnets" {
  type        = list(string)
  default     = [] 
}

####MSSQL-EC2###############

variable "mssql_ami" {
  type        = string
  description = "The ID of the Amazon Machine Image (AMI) used to launch the instance"
}

variable "mssql_ec2_instance_type" {
  type        = string
  description = "The type of EC2 instance to launch"
}

variable "ec2_mssql_tags" {
  type = map(string)
}

variable "mssql_ec2_key_name" {
  type        = string
  description = "jumpserver name"
}

variable "mssql_subnet" {
  type = string
  default = ""
}

variable "mssql_vpc_id" {
  type        = string
  default = ""
}

###########linux-EC2##############

variable "ami" {
  type        = string
  description = "The ID of the Amazon Machine Image (AMI) used to launch the instance"
}

variable "ec2_instance_type" {
  type        = string
  description = "The type of EC2 instance to launch"
}

variable "ec2_key_name" {
  type        = string
  description = "jumpserver name"
}

variable "linux_tags" {
  type = map(string)
}

variable "linux_subnet" {
  type        = string
  default = ""
}

variable "linux_vpc_id" {
  type        = string
  default = ""
}

#########EKS###################

variable "k8s_version" {
  description = "Kubernetes version."
  type        = string
}


variable "cluster-name" {
  description = "The name of the cluster"
  type        = string
}

variable "cloudwatch_logs" {
  type        = bool
  description = "Setup full Cloudwatch logging."
}

variable "cluster-autoscaler" {
  type        = bool
  description = "Install k8s Cluster Autoscaler."
}

#variable "inst_disk_size" {
#  description = "EKS worker instance disk size in Gb."
#  type        = string
#  default     = "50"
#}

#variable "inst_key_pair" {
#  description = "EKS worker instance ssh key pair."
#  type        = string
#  default     = "test-keypair"
#}

#variable "public_key_file" {
#  type        = string
#  description = "File path to the public key file"
#}

variable "eks_tags" {
  type = map(string)
}

variable "eks_subnets" {
  type        = list(string)
  default     = []
}


variable "eks_vpc_cidr" {
  type        = string
  default = ""
}

variable "eks_vpc_id" {
  type        = string
  default = ""
}

#############RDS############

variable "rds_db_instance_identifier" {
  type        = string
  description = "Please mention the Database Instance Identifier"
}

variable "rds_database_name" {
  type        = string
  description = "rds Database Name"
}

variable "database_password" {
  type        = string
  description = "rds Database Password"
}

variable "database_user" {
  type        = string
  description = "rds Database Username"
}

variable "major_version" {
  type        = string
  description = "rds Database Parameter Group Major Version"
}

variable "engine_version" {
  type        = string
  description = "rds Database Engine Version"
}

variable "rds_db_security_group" {
  type        = string
  description = "rds Database Security Group"
}

variable "rds_db_instance_type" {
  type        = string
  description = "rds Database Instance Type"
}

variable "rds_db_allocated_storage" {
  type        = string
  description = "rds Database Storage Size"
}

#variable "rds__db_cidr_range" {
#  type        = string
#  description = "rds CIDR Range"
#  default     = ""
#}

variable "rds_port" {
  type        = string
  description = "rds CIDR Range"
}

variable "rds_tags" {
  type = map(string)
}

variable "rds_vpc_cidr" {
  type        = string
  default = ""
}

variable "rds_subnets" {
  type        = list(string)
  default     = []
}

variable "rds_vpc_id" {
  type        = string
  default = ""
}