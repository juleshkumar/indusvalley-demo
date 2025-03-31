variable "from_ports_sg" {
  description = "Starting port for the rule"
  type        = number
}

variable "to_ports_sg" {
  description = "Ending port for the rule"
  type        = number
}

variable "protocol_sg" {
  description = "Protocol to use (tcp, udp, etc.)"
  type        = string
}

variable "cidr_blocks_sg" {
  description = "CIDR blocks to allow traffic from"
  type        = list(string)
}

variable "backend_bucket_sg" {
  description = "Protocol to use (tcp, udp, etc.)"
  type        = string
}

variable "region_sg" {
  description = "Protocol to use (tcp, udp, etc.)"
  type        = string
}

variable "backend_path_sg" {
  description = "Protocol to use (tcp, udp, etc.)"
  type        = string
}

variable "backend_key_sg" {
  description = "Protocol to use (tcp, udp, etc.)"
  type        = string
}
