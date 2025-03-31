data "terraform_remote_state" "vpc_state" {
  backend = "s3"
  config = {
    bucket     = var.backend_bucket
    key        = "${var.backend_path}/backend/vpc"
    region     = var.region
  }
}

# IAM Role for EC2 with SSM access
resource "aws_iam_role" "ec2_ssm_role" {
  name               = "ec2-ssm-role"
  description        = "IAM role for EC2 instances with SSM access"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Name = "EC2-SSM-Role"
  }
}

resource "aws_iam_instance_profile" "ec2_ssm_instance_profile" {
  name = "linux-ec2-ssm-instance-profile"
  role = aws_iam_role.ec2_ssm_role.name
}

resource "aws_iam_role_policy_attachment" "ssm_full_access" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_security_group" "securitygroup-jump" {
  name        = "linux-${var.ec2_key_name}-alpha"
  description = "Default SG to allow traffic from the VPC mysg"
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id

  ingress {
    from_port   = 22 # RDP port
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "master" {
  ami                         = var.ami
  instance_type               = var.ec2_instance_type
  key_name                    = var.ec2_key_name
  subnet_id                   = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids[0]
  vpc_security_group_ids      = [aws_security_group.securitygroup-jump.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_ssm_instance_profile.name
  associate_public_ip_address = false
  tags                        = var.linux_tags

  lifecycle {
    create_before_destroy = true
  }
}