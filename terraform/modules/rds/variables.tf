variable "rds_db_instance_identifier" {
  type        = string
  description = "Please mention the Database Instance Identifier"
  default     = "test-db-tech"
}

variable "rds_database_name" {
  type        = string
  description = "rds Database Name"
  default     = "test_database"
}

variable "database_password" {
  type        = string
  description = "rds Database Password"
  default     = "Qwerty#789"
}

variable "database_user" {
  type        = string
  description = "rds Database Username"
  default     = "dbadmin"
}

variable "major_version" {
  type        = string
  description = "rds Database Parameter Group Major Version"
  default     = "12"
}

variable "engine_version" {
  type        = string
  description = "rds Database Engine Version"
  default     = "12.18"
}

variable "rds_db_security_group" {
  type        = string
  description = "rds Database Security Group"
  default     = "test-sg"
}

variable "rds_db_instance_type" {
  type        = string
  description = "rds Database Instance Type"
  default     = "db.m6g.large"
}

variable "rds_db_allocated_storage" {
  type        = string
  description = "rds Database Storage Size"
  default     = "20"
}

#variable "rds__db_cidr_range" {
#  type        = string
#  description = "rds CIDR Range"
#  default     = ""
#}

variable "rds_port" {
  type        = string
  description = "rds CIDR Range"
  default     = "5432"
}

variable "region" {
  type = string
  default     = "ap-south-1"
}

variable "backend_bucket" {
  type = string
}

variable "rds_tags" {
  type = map(string)
  default = {
    Environment = "dev"
  }
}

variable "backend_path" {
  description = "The name of the cluster"
  type        = string
}
