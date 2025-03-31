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
