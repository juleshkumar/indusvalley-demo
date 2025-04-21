variable "cluster-name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "k8s_version" {
  description = "Kubernetes version."
  type        = string
}

variable "cloudwatch_logs" {
  type        = bool
  description = "Setup full CloudWatch logging."
}

variable "environment" {
  type        = string
  description = "The environment name (e.g., production, staging)."
}

variable "ec2_root_volume_size" {
  type        = string
}

variable "key_name" {
  type        = string
}

variable "eks_cluster_sg_id" {
  type        = string
}

variable "app_env_type" {
  type        = string
}

variable "project" {
  type        = string
}

variable "ng_vpc_id" {
  type        = string
}

variable "eks_cluster_id" {
  type        = string
}

variable "ng_kms_arn" {
  type        = string
}

variable "ng_subnets" {
  type        = list(string)
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