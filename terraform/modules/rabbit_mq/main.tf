data "aws_secretsmanager_secret" "rabbitmq" {
  name = "rabbitmq/credentials"
}
data "aws_secretsmanager_secret_version" "rabbitmq" {
  secret_id = data.aws_secretsmanager_secret.rabbitmq.id
}

locals {
  rabbitmq_secret = jsondecode(data.aws_secretsmanager_secret_version.rabbitmq.secret_string)
}

resource "aws_security_group" "mq_sg" {
  name        = var.mq_security_group_name
  description = var.mq_security_group_description
  vpc_id      = var.mq_vpc_id

  ingress {
    from_port   = var.mq_port
    to_port     = var.mq_port
    protocol    = "tcp"
    cidr_blocks = var.mq_allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.mq_tags
}

resource "aws_mq_broker" "rabbitmq_broker" {
  broker_name           = var.broker_name
  engine_type           = "RABBITMQ"
  engine_version        = var.mq_engine_version
  host_instance_type    = var.host_instance_type
  deployment_mode       = var.deployment_mode
  publicly_accessible   = var.publicly_accessible
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately     = var.apply_immediately
  storage_type          = var.storage_type
  subnet_ids            = var.mq_subnet_ids
  security_groups       = [aws_security_group.mq_sg.id]
  logs {
    general = var.logs_general
  }
  maintenance_window_start_time {
    day_of_week = var.maintenance_day
    time_of_day = var.maintenance_time
    time_zone   = var.maintenance_timezone
  }

  user {
    username = var.mq_username
    password = local.rabbitmq_secret.password
    console_access = var.console_access
    groups   = var.user_groups
  }

  tags = var.mq_tags
}
