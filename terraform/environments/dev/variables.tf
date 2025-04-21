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

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "environment" {
  type        = string
  description = "environment"
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
##############KMS#####################
variable "kms_key_name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "kms_tags" {
  type = map(string)
  
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
}###being used in ndoegroup also###

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

variable "eks_kms_arn" {
  type        = string
  default = ""
}

###########Nodegroups###########################
variable "ec2_root_volume_size" {
  type        = string
}

variable "key_name" {
  type        = string
}

variable "eks_cluster_sg_id" {
  type        = string
  default = ""
}

variable "app_env_type" {
  type        = string
}

variable "project" {
  type        = string
}

variable "ng_kms_arn" {
  type        = string
  default = ""
}

variable "ng_vpc_id" {
  type        = string
  default = ""
}

variable "eks_cluster_id" {
  type        = string
  default = ""
}

variable "ng_subnets" {
  type        = list(string)
  default = []
}


variable "node_groups_test" {
  description = "List of node groups with specific ingress and egress rules"
  type = list(object({
    name            = string
    instance_types  = list(string)
    ng_test_tags = map(string)
    labels          = map(string)
    tolerations     = object({
      key    = string
      value  = string
      effect = string
    })
    minimum_size    = number
    maximum_size    = number
    desired_size    = number
    capacity_type   = string
    inst_disk_size  = number

    # Ingress and egress rules for each node group
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))

    egress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}

variable "node_groups_test_tt" {
  description = "List of node groups with specific ingress and egress rules"
  type = list(object({
    name            = string
    instance_types  = list(string)
    ng_test_tags = map(string)
    labels          = map(string)
    minimum_size    = number
    maximum_size    = number
    desired_size    = number
    capacity_type   = string
    inst_disk_size  = number

    # Ingress and egress rules for each node group
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))

    egress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
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

variable "rds_kms_arn" {
  type        = string
  default = ""
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

##############elasticache#############

variable "redis-cluster" {
  type        = string
  description = "The ID of the ElastiCache cluster"
}

variable "redis-engine" {
  type        = string
  description = "The name of the cache engine to be used for the clusters in this replication group"
}

variable "redis-engine-version" {
  type        = string
  description = "The version number of the cache engine to be used for the cache clusters in this replication group"
}

variable "redis-node-type" {
  type        = string
  description = "The compute and memory capacity of the nodes in the node group"
}

#variable "num-cache-nodes" {
#  description = "The initial number of cache nodes that the cache cluster has"
#  type        = number
#}

variable "num-node-groups" {
  description = "The number of node groups (shards) for this Redis replication group"
  type        = number
}

variable "replicas-per-node-group" {
  description = "The number of replica nodes in each node group (shard)"
  type        = number
}

variable "parameter-group-family" {
  description = "The initial number of cache nodes that the cache cluster has"
  type        = string
}

variable "replication-id" {
  type        = string
  description = "(optional) describe your variable"
}

variable "elasticache_tags" {
  type = map(string)
}

variable "redis-user-id" {
  type = string
}

variable "redis-user-name" {
  type = string
}

variable "redis_port" {
  type        = string
  description = "VRT CIDR Range"
}

variable "redis-user-group" {
  description = "The name of the cluster"
  type        = string
}

variable "redis_subnets" {
  type        = list(string)
  default = []
}

variable "redis_vpc_cidr_block" {
  type        = string
  default = ""
}

variable "redis_vpc_id" {
  type        = string
  default = ""
}
variable "redis_rest_encryption" {
  type        = string
}

variable "redis_kms_arn" {
  type        = string
  default = ""
}

variable "redis_transit_encryption" {
  type        = string
}


###########RabbitMQ################
variable "broker_name" {
  description = "Name of the RabbitMQ broker"
  type        = string
}

variable "mq_engine_version" {
  description = "RabbitMQ engine version"
  type        = string
}

variable "host_instance_type" {
  description = "Instance type for the broker"
  type        = string
}

variable "deployment_mode" {
  description = "Deployment mode - SINGLE_INSTANCE or ACTIVE_STANDBY_MULTI_AZ"
  type        = string
}

variable "publicly_accessible" {
  description = "Whether the broker is publicly accessible"
  type        = bool
}

variable "auto_minor_version_upgrade" {
  description = "Enable automatic minor version upgrades"
  type        = bool
}

variable "apply_immediately" {
  description = "Apply changes immediately"
  type        = bool
}

variable "storage_type" {
  description = "Storage type - e.g., efs or amazon-ebs"
  type        = string
}

variable "mq_subnet_ids" {
  description = "List of subnet IDs for the broker"
  type        = list(string)
  default = []
}

variable "logs_general" {
  description = "Enable general logging"
  type        = bool
}

variable "maintenance_day" {
  description = "Preferred maintenance day"
  type        = string
}

variable "maintenance_time" {
  description = "Preferred maintenance start time"
  type        = string
}

variable "maintenance_timezone" {
  description = "Timezone for maintenance window"
  type        = string
}

variable "mq_username" {
  description = "Username for RabbitMQ broker access"
  type        = string
}

variable "console_access" {
  description = "Allow user console access"
  type        = bool
}

variable "user_groups" {
  description = "Groups to which the user belongs"
  type        = list(string)
}

variable "mq_vpc_id" {
  description = "VPC ID for security group"
  type        = string
  default = ""
}

variable "mq_security_group_name" {
  description = "Security group name"
  type        = string
}

variable "mq_security_group_description" {
  description = "Security group description"
  type        = string
}

variable "mq_port" {
  description = "Port to allow for RabbitMQ"
  type        = number
}

variable "mq_allowed_cidrs" {
  description = "CIDR blocks allowed to access RabbitMQ"
  type        = list(string)
}

variable "mq_tags" {
  description = "Tags to assign to resources"
  type        = map(string)
}