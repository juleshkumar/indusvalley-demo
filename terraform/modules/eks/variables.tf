variable "k8s_version" {
  description = "Kubernetes version."
  type        = string
  default     = "1.31"
}


variable "cluster-name" {
  description = "The name of the cluster"
  type        = string
  default     = "test-eks-cluster"
}

variable "cloudwatch_logs" {
  type        = bool
  description = "Setup full Cloudwatch logging."
  default     = "false"
}

variable "cluster-autoscaler" {
  type        = bool
  description = "Install k8s Cluster Autoscaler."
  default     = "false"
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
  default = {
    Environment = "dev"
  }
}

variable "region" {
  type = string
  default     = "ap-south-1"
}

variable "backend_path" {
  description = "The name of the cluster"
  type        = string
}

variable "backend_bucket" {
  type = string
}
