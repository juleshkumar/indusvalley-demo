
resource "aws_launch_template" "eks_decimal0" {
  name_prefix            = "${var.cluster-name}-decimal0"
  description            = "Default Launch-Template"
  update_default_version = true

#  image_id = "ami-08a0d1e16fc3f61ea"

#  instance_type = var.instance-type-decimal0

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 20
      volume_type           = "gp2"
      delete_on_termination = true
      encrypted             = true

      # Enable this if you want to encrypt your node root volumes with a KMS/CMK. encryption of PVCs is handled via k8s StorageClass tho
      # you also need to attach data.aws_iam_policy_document.ebs_decryption.json from the disk_encryption_policy.tf to the KMS/CMK key then !!
      # kms_key_id            = var.kms_key_arn
    }
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    delete_on_termination       = true
    security_groups             = [data.terraform_remote_state.eks.outputs.eks_allow_vpc_cidr_sg_id, data.terraform_remote_state.eks.outputs.eks_cluster_sg_id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name      = "${var.cluster-name}-application-node"
      CustomTag = "Instance custom tag"
    }
  }

  # Supplying custom tags to EKS instances root volumes is another use-case for LaunchTemplates. (doesnt add tags to dynamically provisioned volumes via PVC)
  tag_specifications {
    resource_type = "volume"

    tags = {
      CustomTag = "Volume custom tag"
    }
  }

  # Supplying custom tags to EKS instances ENI's is another use-case for LaunchTemplates
  tag_specifications {
    resource_type = "network-interface"

    tags = {
      CustomTag = "${var.cluster-name}-decimal0"
    }
  }

  # Tag the LT itself
  tags = {
    CustomTag = "Launch template custom tag"
  }

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_launch_template" "eks_decimal1" {
  name_prefix            = "${var.cluster-name}-decimal1"
  description            = "Default Launch-Template"
  update_default_version = true

#  image_id = "ami-08a0d1e16fc3f61ea"

#  instance_type = var.instance-type-decimal0

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 20
      volume_type           = "gp2"
      delete_on_termination = true
      encrypted             = true

      # Enable this if you want to encrypt your node root volumes with a KMS/CMK. encryption of PVCs is handled via k8s StorageClass tho
      # you also need to attach data.aws_iam_policy_document.ebs_decryption.json from the disk_encryption_policy.tf to the KMS/CMK key then !!
      # kms_key_id            = var.kms_key_arn
    }
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    delete_on_termination       = true
    security_groups             = [data.terraform_remote_state.eks.outputs.eks_allow_vpc_cidr_sg_id, data.terraform_remote_state.eks.outputs.eks_cluster_sg_id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name      = "${var.cluster-name}-toolstack-node"
      CustomTag = "Instance custom tag"
    }
  }

  # Supplying custom tags to EKS instances root volumes is another use-case for LaunchTemplates. (doesnt add tags to dynamically provisioned volumes via PVC)
  tag_specifications {
    resource_type = "volume"

    tags = {
      CustomTag = "Volume custom tag"
    }
  }

  # Supplying custom tags to EKS instances ENI's is another use-case for LaunchTemplates
  tag_specifications {
    resource_type = "network-interface"

    tags = {
      CustomTag = "${var.cluster-name}-decimal1"
    }
  }

  # Tag the LT itself
  tags = {
    CustomTag = "Launch template custom tag"
  }

  lifecycle {
    create_before_destroy = true
  }
}




resource "aws_launch_template" "eks_decimal2" {
  name_prefix            = "${var.cluster-name}-decimal2"
  description            = "Default Launch-Template"
  update_default_version = true

#  image_id = "ami-08a0d1e16fc3f61ea"

#  instance_type = var.instance-type-decimal0

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 20
      volume_type           = "gp2"
      delete_on_termination = true
      encrypted             = true

      # Enable this if you want to encrypt your node root volumes with a KMS/CMK. encryption of PVCs is handled via k8s StorageClass tho
      # you also need to attach data.aws_iam_policy_document.ebs_decryption.json from the disk_encryption_policy.tf to the KMS/CMK key then !!
      # kms_key_id            = var.kms_key_arn
    }
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    delete_on_termination       = true
    security_groups             = [data.terraform_remote_state.eks.outputs.eks_allow_vpc_cidr_sg_id, data.terraform_remote_state.eks.outputs.eks_cluster_sg_id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name      = "${var.cluster-name}-nginx"
      CustomTag = "Instance custom tag"
    }
  }

  # Supplying custom tags to EKS instances root volumes is another use-case for LaunchTemplates. (doesnt add tags to dynamically provisioned volumes via PVC)
  tag_specifications {
    resource_type = "volume"

    tags = {
      CustomTag = "Volume custom tag"
    }
  }

  # Supplying custom tags to EKS instances ENI's is another use-case for LaunchTemplates
  tag_specifications {
    resource_type = "network-interface"

    tags = {
      CustomTag = "${var.cluster-name}-decimal2"
    }
  }

  # Tag the LT itself
  tags = {
    CustomTag = "Launch template custom tag"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_launch_template" "eks_decimal3" {
  name_prefix            = "${var.cluster-name}-decimal3"
  description            = "Default Launch-Template"
  update_default_version = true

#  image_id = "ami-08a0d1e16fc3f61ea"

#  instance_type = var.instance-type-decimal0

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 20
      volume_type           = "gp2"
      delete_on_termination = true
      encrypted             = true

      # Enable this if you want to encrypt your node root volumes with a KMS/CMK. encryption of PVCs is handled via k8s StorageClass tho
      # you also need to attach data.aws_iam_policy_document.ebs_decryption.json from the disk_encryption_policy.tf to the KMS/CMK key then !!
      # kms_key_id            = var.kms_key_arn
    }
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    delete_on_termination       = true
    security_groups             = [data.terraform_remote_state.eks.outputs.eks_allow_vpc_cidr_sg_id, data.terraform_remote_state.eks.outputs.eks_cluster_sg_id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name      = "${var.cluster-name}-custom-application"
      CustomTag = "Instance custom tag"
    }
  }

  # Supplying custom tags to EKS instances root volumes is another use-case for LaunchTemplates. (doesnt add tags to dynamically provisioned volumes via PVC)
  tag_specifications {
    resource_type = "volume"

    tags = {
      CustomTag = "Volume custom tag"
    }
  }

  # Supplying custom tags to EKS instances ENI's is another use-case for LaunchTemplates
  tag_specifications {
    resource_type = "network-interface"

    tags = {
      CustomTag = "${var.cluster-name}-decimal3"
    }
  }

  # Tag the LT itself
  tags = {
    CustomTag = "Launch template custom tag"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "eks_decimal4" {
  name_prefix            = "${var.cluster-name}-decimal4"
  description            = "Default Launch-Template"
  update_default_version = true

#  image_id = "ami-08a0d1e16fc3f61ea"

#  instance_type = var.instance-type-decimal0

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 20
      volume_type           = "gp2"
      delete_on_termination = true
      encrypted             = true

      # Enable this if you want to encrypt your node root volumes with a KMS/CMK. encryption of PVCs is handled via k8s StorageClass tho
      # you also need to attach data.aws_iam_policy_document.ebs_decryption.json from the disk_encryption_policy.tf to the KMS/CMK key then !!
      # kms_key_id            = var.kms_key_arn
    }
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    delete_on_termination       = true
    security_groups             = [data.terraform_remote_state.eks.outputs.eks_allow_vpc_cidr_sg_id, data.terraform_remote_state.eks.outputs.eks_cluster_sg_id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name      = "${var.cluster-name}-vrt-redis-nodegroup"
      CustomTag = "Instance custom tag"
    }
  }

  # Supplying custom tags to EKS instances root volumes is another use-case for LaunchTemplates. (doesnt add tags to dynamically provisioned volumes via PVC)
  tag_specifications {
    resource_type = "volume"

    tags = {
      CustomTag = "Volume custom tag"
    }
  }

  # Supplying custom tags to EKS instances ENI's is another use-case for LaunchTemplates
  tag_specifications {
    resource_type = "network-interface"

    tags = {
      CustomTag = "${var.cluster-name}-decimal4"
    }
  }

  # Tag the LT itself
  tags = {
    CustomTag = "Launch template custom tag"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "eks_decimal5" {
  name_prefix            = "${var.cluster-name}-decimal5"
  description            = "Default Launch-Template"
  update_default_version = true

#  image_id = "ami-08a0d1e16fc3f61ea"

#  instance_type = var.instance-type-decimal0

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 20
      volume_type           = "gp2"
      delete_on_termination = true
      encrypted             = true

      # Enable this if you want to encrypt your node root volumes with a KMS/CMK. encryption of PVCs is handled via k8s StorageClass tho
      # you also need to attach data.aws_iam_policy_document.ebs_decryption.json from the disk_encryption_policy.tf to the KMS/CMK key then !!
      # kms_key_id            = var.kms_key_arn
    }
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    delete_on_termination       = true
    security_groups             = [data.terraform_remote_state.eks.outputs.eks_allow_vpc_cidr_sg_id, data.terraform_remote_state.eks.outputs.eks_cluster_sg_id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name      = "${var.cluster-name}-vrt-observability-nodegroup"
      CustomTag = "Instance custom tag"
    }
  }

  # Supplying custom tags to EKS instances root volumes is another use-case for LaunchTemplates. (doesnt add tags to dynamically provisioned volumes via PVC)
  tag_specifications {
    resource_type = "volume"

    tags = {
      CustomTag = "Volume custom tag"
    }
  }

  # Supplying custom tags to EKS instances ENI's is another use-case for LaunchTemplates
  tag_specifications {
    resource_type = "network-interface"

    tags = {
      CustomTag = "${var.cluster-name}-decimal5"
    }
  }

  # Tag the LT itself
  tags = {
    CustomTag = "Launch template custom tag"
  }

  lifecycle {
    create_before_destroy = true
  }
}
