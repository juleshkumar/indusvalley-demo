
data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket     = var.backend_bucket
    key        = "${var.backend_path}/backend/vpc"
    region     = var.region
  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket     = var.backend_bucket
    key        = "${var.backend_path}/backend/eks"
    region     = var.region
  }
}

data "terraform_remote_state" "lb" {
  backend = "s3"

  config = {
    bucket   = var.backend_bucket
    key      = "${var.backend_path}/backend/load_balancer"
    region   = var.region
  }
}


resource "aws_iam_role" "node" {
  name = "eks-${var.cluster-name}-node-0"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "node_ca" {
  #  count      = cluster-autoscaler ? 1 : 0
  name        = "eks-${var.cluster-name}-ca"
  path        = "/"
  description = "EKS Cluster Autoscaler policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeTags",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "ec2:DescribeLaunchTemplateVersions"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEBSCSIDriverPolicy-node" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEFSCsiDriverPolicy-node" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "CloudWatchAgentServerPolicy" {
  count      = var.cloudwatch_logs ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node_ca" {
  #  count      = cluster-autoscaler ? 1 : 0
  policy_arn = aws_iam_policy.node_ca.arn
  role       = aws_iam_role.node.name
}

resource "tls_private_key" "ssh_server_eks" {

  algorithm = "RSA"
  rsa_bits  = 2048
}


resource "aws_key_pair" "eks" {
  key_name   = var.eks_key_name
  public_key = var.public_key_file != null ? file(var.public_key_file) : tls_private_key.ssh_server_eks.public_key_openssh
}

# Define the security group for EFS mount targets
resource "aws_security_group" "efs_mount_target_sg" {
  name_prefix = "efs-mount-target-sg-"
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id

  # Define ingress rules
  ingress {
    description = "Allow NFS traffic from within the VPC"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }

  ingress {
    description = "Allow SSH traffic from within the VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }

  ingress {
    description = "Allow all inbound traffic from VPC CIDR"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }

  ingress {
    description = "Allow HTTP traffic from within the VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }

    ingress {
    description       = "Allow HTTP traffic from the Load Balancer"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    security_groups = [data.terraform_remote_state.lb.outputs.security_groups]
  }

  ingress {
    description = "Allow HTTPS traffic from within the VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Define egress rules to allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_eks_node_group" "decimal0" {
  count           = var.count_decimal0
  cluster_name    = data.terraform_remote_state.eks.outputs.eks_cluster_id
  node_group_name = "${var.cluster-name}-${var.node_groups_decimal0[count.index].name}"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids
  instance_types  = var.instance-type-decimal0
 # ami_type        = "CUSTOM"
  capacity_type   = var.instance_capacity_types_decimal0 
  

  launch_template {
    id    = aws_launch_template.eks_decimal0.id
    version = "$Latest"
  }

  scaling_config {
    desired_size = var.app-desired-workers-decimal0
    max_size     = var.app-max-workers-decimal0
    min_size     = var.app-min-workers-decimal0
  }

  tags = {
    "Name"        = "${var.cluster-name}-decimal0"
    "Environment" = var.environment
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_node_group" "decimal1" {
  count           = var.count_decimal1
  cluster_name    = data.terraform_remote_state.eks.outputs.eks_cluster_id
  node_group_name = "${var.cluster-name}-${var.node_groups_decimal1[count.index].name}"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids
  instance_types  = var.instance-type-on-decimal1
  capacity_type   = var.instance_capacity_types_decimal1

  launch_template {
    id    = aws_launch_template.eks_decimal1.id
    version = "$Latest"
  }


  labels = {
    vrt-cug-kafka     = "true",
    vrt-elk           = "true",
    vrt-cug-consul    = "true",
    vrt-cug-logstash  = "true",
  }

  taint {
    key    = "key"
    value  = "persistTool"
    effect = "NO_SCHEDULE"
  }

  scaling_config {
    desired_size = var.tool-desired-workers-decimal1
    max_size     = var.tool-max-workers-decimal1
    min_size     = var.tool-min-workers-decimal1
  }

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name"        = "${var.cluster-name}-decimal1"
    "Environment" = var.environment
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}


resource "aws_iam_instance_profile" "eks_instance_profile" {
  name = "${var.cluster-name}-instance-profile"
  role = aws_iam_role.node.name
}


resource "aws_autoscaling_attachment" "ngas1" {
  count                  = var.count_decimal1
  autoscaling_group_name = aws_eks_node_group.decimal2[count.index].resources[0].autoscaling_groups[0].name
  lb_target_group_arn    = data.terraform_remote_state.lb.outputs.lb_target_arn
}


resource "aws_eks_node_group" "decimal2" {
  count           = var.count_decimal2
  cluster_name    = data.terraform_remote_state.eks.outputs.eks_cluster_id
  node_group_name = "${var.cluster-name}-${var.node_groups_decimal2[count.index].name}"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids
  instance_types  = var.instance-type-decimal2
  capacity_type   = var.instance_capacity_types_decimal2

  launch_template {
    id    = aws_launch_template.eks_decimal2.id
    version = "$Latest"
  }


  labels = {
    vrt-cug-nginx     = "true",
  }

  taint {
    key    = "key"
    value  = "persistTool"
    effect = "NO_SCHEDULE"
  }

  scaling_config {
    desired_size = var.nginx-desired-workers-decimal2
    max_size     = var.nginx-max-workers-decimal2
    min_size     = var.nginx-min-workers-decimal2
  }

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name"        = "${var.cluster-name}-decimal2"
    "Environment" = var.environment
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}
resource "aws_eks_node_group" "decimal3" {
  count           = var.count_decimal3
  cluster_name    = data.terraform_remote_state.eks.outputs.eks_cluster_id
  node_group_name = "${var.cluster-name}-${var.node_groups_decimal3[count.index].name}"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids
  instance_types  = var.instance-type-on-decimal3
  capacity_type   = var.instance_capacity_types_decimal3

  launch_template {
    id    = aws_launch_template.eks_decimal3.id
    version = "$Latest"
  }


  scaling_config {
    desired_size = var.cust-app-desired-workers-decimal3
    max_size     = var.cust-app-max-workers-decimal3
    min_size     = var.cust-app-min-workers-decimal3
  }

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name"        = "${var.cluster-name}-decimal3"
    "Environment" = var.environment
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}
resource "aws_eks_node_group" "decimal4" {
  count           = var.count_decimal4
  cluster_name    = data.terraform_remote_state.eks.outputs.eks_cluster_id
  node_group_name = "${var.cluster-name}-${var.node_groups_decimal4[count.index].name}"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids
  instance_types  = var.instance-type-decimal4
  capacity_type   = var.instance_capacity_types_decimal4

  launch_template {
    id    = aws_launch_template.eks_decimal4.id
    version = "$Latest"
  }


  labels = {
    vrt-redis     = "true",
  }

  taint {
    key    = "key"
    value  = "persistTool"
    effect = "NO_SCHEDULE"
  }

  scaling_config {
    desired_size = var.redis-desired-workers-decimal4
    max_size     = var.redis-max-workers-decimal4
    min_size     = var.redis-min-workers-decimal4
  }

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name"        = "${var.cluster-name}-decimal4"
    "Environment" = var.environment
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}

  resource "aws_eks_node_group" "decimal5" {
    count           = var.count_decimal5
    cluster_name    = data.terraform_remote_state.eks.outputs.eks_cluster_id
    node_group_name = "${var.cluster-name}-${var.node_groups_decimal5[count.index].name}"
    node_role_arn   = aws_iam_role.node.arn
    subnet_ids      = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids
    instance_types  = var.instance-type-decimal5
    capacity_type   = var.instance_capacity_types_decimal5
  
    launch_template {
      id    = aws_launch_template.eks_decimal5.id
      version = "$Latest"
    }
  
  
    labels = {
      vrt-observability     = "true",
    }
  
    taint {
      key    = "key"
      value  = "persistTool"
      effect = "NO_SCHEDULE"
    }
  
    scaling_config {
      desired_size = var.observability-desired-workers-decimal5
      max_size     = var.observability-max-workers-decimal5
      min_size     = var.observability-min-workers-decimal5
    }
  
    lifecycle {
      create_before_destroy = true
    }
    tags = {
      "Name"        = "${var.cluster-name}-decimal5"
      "Environment" = var.environment
    }
  
    # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
    # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
    depends_on = [
      aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
      aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
      aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
    ]
  }
