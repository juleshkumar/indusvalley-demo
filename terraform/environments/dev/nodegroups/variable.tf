


variable "cluster-name" {
  description = "The name of the cluster"
  type        = string
}


variable "tool-max-workers-decimal1" {
  description = "Max number of eks worker instances that can be scaled."
  type        = string
}

variable "app-max-workers-decimal0" {
  description = "Max number of eks worker instances that can be scaled."
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

variable "instance_capacity_types_decimal1" {
  description = "EKS worker instance capacity types."
  type        = string
}

variable "instance_capacity_types_decimal0" {
  description = "EKS worker instance capacity types."
  type        = string
}

variable "inst_disk_size" {
  description = "EKS worker instance disk size in Gb."
  type        = string
}

variable "inst_key_pair" {
  description = "EKS worker instance ssh key pair."
  type        = string
}

variable "app-min-workers-decimal0" {
  description = "Number of eks worker instances to deploy."
  type        = string
}

variable "tool-min-workers-decimal1" {
  description = "Number of eks worker instances to deploy."
  type        = string
}

variable "instance-type-on-decimal1" {
  description = "EKS worker instance type."
  type        = list(string)
}

variable "instance-type-decimal0" {
  description = "EKS worker instance type."
  type        = list(string)
}

variable "public_key_file" {
  type        = string
  description = "File path to the public key file"
}

variable "eks_key_name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "environment" {
  type = string
}


variable "region" {
  type = string
}

variable "backend_bucket" {
  type = string
}

variable "node_groups_decimal0" {
  description = "List of node groups for decimal0"
  type = list(object({
    name = string
  }))
}

variable "node_groups_decimal1" {
  description = "List of node groups for decimal1"
  type = list(object({
    name = string
  }))
}

variable "count_decimal0" {
  description = "Number of node groups for decimal0"
  type        = number
}

variable "count_decimal1" {
  description = "Number of node groups for decimal1"
  type        = number
}


variable "nginx-max-workers-decimal2" {
  description = "Max number of eks worker instances that can be scaled."
  type        = string
}

variable "count_decimal2" {
  description = "Number of node groups for decimal1"
  type        = number
}

variable "node_groups_decimal2" {
  description = "List of node groups for decimal1"
  type = list(object({
    name = string
  }))
}

variable "instance-type-decimal2" {
  description = "EKS worker instance type."
  type        = list(string)
}

variable "nginx-min-workers-decimal2" {
  description = "Number of eks worker instances to deploy."
  type        = string
}

variable "instance_capacity_types_decimal2" {
  description = "EKS worker instance capacity types."
  type        = string
}
variable "count_decimal3" {
  description = "The number of decimal3 node groups."
  type        = number
  default     = 1
}

variable "node_groups_decimal3" {
  description = "A list of maps with the node group configurations for decimal3."
  type        = list(object({
    name = string
  }))
}

variable "instance-type-on-decimal3" {
  description = "The instance types for the decimal3 node group."
  type        = list(string)
}

variable "instance_capacity_types_decimal3" {
  description = "The capacity type for the decimal3 node group."
  type        = string
}

variable "cust-app-min-workers-decimal3" {
  description = "The desired number of worker nodes for decimal3."
  type        = number
}

variable "cust-app-max-workers-decimal3" {
  description = "The maximum number of worker nodes for decimal3."
  type        = number
}

variable "redis-max-workers-decimal4" {
  description = "The maximum number of worker nodes for decimal4."
  type        = number
}

variable "observability-max-workers-decimal5" {
  description = "The maximum number of worker nodes for decimal5."
  type        = number
}

variable "redis-min-workers-decimal4" {
  description = "The desired number of worker nodes for decimal4."
  type        = number
}

variable "observability-min-workers-decimal5" {
  description = "The desired number of worker nodes for decimal5."
  type        = number
}

variable "instance_capacity_types_decimal4" {
  description = "The capacity type for the decimal4 node group."
  type        = string
}

variable "instance_capacity_types_decimal5" {
  description = "The capacity type for the decimal5 node group."
  type        = string
}

variable "instance-type-decimal4" {
  description = "The instance types for the decimal4 node group."
  type        = list(string)
}

variable "instance-type-decimal5" {
  description = "The instance types for the decimal5 node group."
  type        = list(string)
}

variable "node_groups_decimal4" {
  description = "A list of maps with the node group configurations for decimal4."
  type        = list(object({
    name = string
  }))
}

variable "node_groups_decimal5" {
  description = "A list of maps with the node group configurations for decimal5."
  type        = list(object({
    name = string
  }))
}

variable "count_decimal4" {
  description = "The number of decimal4 node groups."
  type        = number
  default     = 1
}

variable "count_decimal5" {
  description = "The number of decimal5 node groups."
  type        = number
  default     = 1
}

variable "app-desired-workers-decimal0" {
  description = "The desired number of worker nodes for decimal0."
  type        = number
}

variable "tool-desired-workers-decimal1" {
  description = "The desired number of worker nodes for decimal1."
  type        = number
}

variable "nginx-desired-workers-decimal2" {
  description = "The desired number of worker nodes for decimal2."
  type        = number
}

variable "cust-app-desired-workers-decimal3" {
  description = "The desired number of worker nodes for decimal3."
  type        = number
}

variable "redis-desired-workers-decimal4" {
  description = "The desired number of worker nodes for decimal4."
  type        = number
}

variable "observability-desired-workers-decimal5" {
  description = "The desired number of worker nodes for decimal5."
  type        = number
}

 variable "backend_path" {
  description = "The name of the cluster"
  type        = string
}
