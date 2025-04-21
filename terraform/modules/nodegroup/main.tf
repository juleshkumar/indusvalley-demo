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

resource "aws_iam_policy" "ebs_decryption_policy" {
  name = "EBSDecryptionPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "node_ca" {
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

resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "CloudWatchAgentServerPolicy" {
  count      = var.cloudwatch_logs ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node_ca" {
  policy_arn = aws_iam_policy.node_ca.arn
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "attach_ebs_decryption_policy" {
  policy_arn = aws_iam_policy.ebs_decryption_policy.arn
  role       = aws_iam_role.node.name
}

resource "aws_security_group" "node_group_sg" {
  count       = length(var.node_groups_test)
  name        = "${var.cluster-name}-${var.node_groups_test[count.index].name}-sg"
  description = "Security group for EKS node group ${var.node_groups_test[count.index].name}"
  vpc_id      = var.ng_vpc_id

  # Dynamic ingress rules for each node group
  dynamic "ingress" {
    for_each = var.node_groups_test[count.index].ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Dynamic egress rules for each node group
  dynamic "egress" {
    for_each = var.node_groups_test[count.index].egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "${var.cluster-name}-${var.node_groups_test[count.index].name}-sg"
  }
}


resource "aws_eks_node_group" "test" {
  count           = length(var.node_groups_test)
  cluster_name    = var.eks_cluster_id
  node_group_name = "${var.cluster-name}-${var.node_groups_test[count.index].name}"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.ng_subnets
  instance_types = var.node_groups_test[count.index].instance_types
  ami_type        = "CUSTOM"
  capacity_type   = var.node_groups_test[count.index].capacity_type 

  launch_template {
    id      = aws_launch_template.eks_node_lt[0].id
    version = "$Latest"
  }

  labels = var.node_groups_test[count.index].labels

  taint {
    key    = var.node_groups_test[count.index].tolerations.key
    value  = var.node_groups_test[count.index].tolerations.value
    effect = var.node_groups_test[count.index].tolerations.effect
  }

  scaling_config {
    desired_size = var.node_groups_test[count.index].desired_size
    max_size     = var.node_groups_test[count.index].maximum_size
    min_size     = var.node_groups_test[count.index].minimum_size
  }

  tags = var.node_groups_test[count.index].ng_test_tags

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_node_group" "test_no_tt" {
  count           = length(var.node_groups_test_tt)
  cluster_name    = var.eks_cluster_id
  node_group_name = "${var.cluster-name}-${var.node_groups_test_tt[count.index].name}"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.ng_subnets
  instance_types = var.node_groups_test_tt[count.index].instance_types
#  ami_type        = "CUSTOM"
  capacity_type   = var.node_groups_test_tt[count.index].capacity_type 

  launch_template {
    id      = aws_launch_template.eks_node_lt[0].id
    version = "$Latest"
  }

  labels = var.node_groups_test_tt[count.index].labels

  scaling_config {
    desired_size = var.node_groups_test_tt[count.index].desired_size
    max_size     = var.node_groups_test_tt[count.index].maximum_size
    min_size     = var.node_groups_test_tt[count.index].minimum_size
  }

  tags = var.node_groups_test_tt[count.index].ng_test_tags

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
  ]
}