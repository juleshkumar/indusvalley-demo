# Fetching state from a remote backend (S3)
data "terraform_remote_state" "remote_state" {
  backend = "s3"

  config = {
    bucket = var.backend_bucket_sg  # S3 bucket name
    key    = "${var.backend_path_sg}/backend/${var.backend_key_sg}"  # Correct path to the state file
    region = var.region_sg          # AWS region
  }
}

# Add a new inbound rule for the security group
resource "aws_security_group_rule" "new_rule" {
  type              = "ingress"  # Use "egress" for outbound rules
  from_port         = var.from_ports_sg  # Variable for starting port
  to_port           = var.to_ports_sg    # Variable for ending port
  protocol          = var.protocol_sg   # Protocol (tcp, udp, etc.)
  cidr_blocks       = var.cidr_blocks_sg  # CIDR block for inbound traffic
  security_group_id = data.terraform_remote_state.remote_state.outputs.security_groups  # Correct reference to remote state output
}
