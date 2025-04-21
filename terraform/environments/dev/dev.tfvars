region = "us-east-1"

backend_path = "dev"

backend_bucket = "terraform-testing-backend-bucket"

account_id = "296062546708"

####VPC variables################################################
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

#############KMS############
kms_tags = {Environment = "dev"}
kms_key_name = "test-ivp-cmk-key"

###############EC2-MSSQL variables

mssql_ami = "ami-0ee0763aa195c298f"

mssql_ec2_instance_type = "r5.xlarge"

ec2_mssql_tags = {Name: "test-dev-mssql",Environment = "dev"}

mssql_ec2_key_name = "test-keypair"

#EC2-Linux vairbales

ami = "ami-07a6f770277670015"

ec2_instance_type = "t2.micro"

linux_tags = {Name: "test-dev-linux",Environment = "dev"}

ec2_key_name = "test-keypair"

#EKS vairbales

k8s_version = "1.31"

cluster-name =  "test-dev-eks-cluster"

cloudwatch_logs = false

cluster-autoscaler = false

eks_tags = {Name: "test-dev-eks-cluster",Environment = "dev"}

#Nodegroups vairbales

ec2_root_volume_size = "20"

key_name = "test-keypair"

app_env_type = "dev"

project = "indusvalley"

node_groups_test = [
  {
    name           = "nginx-ondemand-new"
    instance_types = ["t3.medium"]
    ng_test_tags = {
      Name        = "nginx-nodegroup-new"
      Environment = "prod"
    }
    labels = {
      vrt-cug-nginx = "true"
    }
    tolerations = {
      key    = "key"
      value  = "persistTool"
      effect = "NO_SCHEDULE"
    }
    minimum_size   = 1
    maximum_size   = 2
    desired_size   = 1
    capacity_type  = "ON_DEMAND"
    inst_disk_size = 50

    ingress_rules = [
      {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress_rules = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
]

node_groups_test_tt = [
  {
    name           = "application-nodegroup-ondemand-new"
    instance_types = ["m6i.large", "t3.medium", "r6i.large"]
    ng_test_tags = {
      Name        = "application-nodegroup-ondemand-new"
      Environment = "prod"
    }
    labels = {
      prod = "true"
    }
    minimum_size   = 2
    maximum_size   = 6
    desired_size   = 2
    capacity_type  = "ON_DEMAND"
    inst_disk_size = 50

    ingress_rules = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress_rules = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
]




#RDS vairbales

rds_db_instance_identifier = "test-dev-db-tech"

rds_database_name = "test_dev_database"

database_user = "dbadmin"

major_version = "12"

engine_version = "12.18"

rds_db_security_group = "test-dev-sg"

rds_db_instance_type = "db.m6g.large"

rds_db_allocated_storage = "20"

rds_port = 5432

rds_tags  = {Name: "test-dev-rds",Environment = "dev"}

#redis_variables######################

redis-cluster = "elasticache-redis-cluster"

redis-engine = "REDIS"

redis-engine-version = "7.0"

redis-node-type = "cache.t3.small"

num-cache-nodes = "1"

num-node-groups = "1"

replicas-per-node-group = "1"

parameter-group-family = "redis7"

replication-id = "test-elasticache-replication"

elasticache_tags = {Name: "elasticache-redis-cluster",Environment = "dev"}

redis-user-id = "redis-user"

redis-user-name = "default"

redis_port = 6379

redis-user-group = "test-user"

redis_transit_encryption = true

redis_rest_encryption = true

###############RabbitMQ################

broker_name              = "my-rabbitmq-broker"
mq_engine_version           = "3.13"               # Use `aws mq describe-broker-engine-types` for available versions
host_instance_type       = "mq.t3.micro"
deployment_mode          = "SINGLE_INSTANCE"       # or "ACTIVE_STANDBY_MULTI_AZ"
publicly_accessible      = false
auto_minor_version_upgrade = true
apply_immediately        = true
storage_type             = "ebs"                   # or "ebs"

mq_subnet_ids               = ["subnet-0f4455b9624291255"]
mq_vpc_id                   = "vpc-09fe2a53f75bc319e"
mq_security_group_name      = "rabbitmq-sg"
mq_security_group_description = "Security group for RabbitMQ broker"
mq_port                  = 5671                     # AMQP TLS port
mq_allowed_cidrs            = ["10.0.0.0/16"]          # Change to allow only required CIDR ranges

mq_username                 = "admin"
console_access           = true
user_groups              = ["admins"]

maintenance_day          = "WEDNESDAY"
maintenance_time         = "02:00"
maintenance_timezone     = "UTC"

logs_general             = true

mq_tags = {Name: "dmeo-mq",Environment = "dev"}




















































