variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
  default     = "10.0.4.0/24"
}

variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = map(string)
  default = {
    Environment = "Prod"
  }
}

variable "igw_tags" {
  description = "Tags for the IGW"
  type        = map(string)
  default = {
    Name = "test"
  }
}

variable "environment" {
  type        = string
  description = "environment for vpc"
  default     = "dev"
}

variable "security_group" {
  type        = string
  description = "vpc security group"
  default     = "test"
}

variable "cluster-name" {
  description = "The name of the cluster"
  type        = string
  default     = "test"
}