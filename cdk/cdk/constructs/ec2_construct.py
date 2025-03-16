# cdk/constructs/ec2_construct.py

from aws_cdk import (
    aws_ec2 as ec2,
    aws_iam as iam,
    CfnOutput,
    Tags,
    Fn,
)
from constructs import Construct

class EC2Construct(Construct):
    def __init__(self, scope: Construct, id: str, *,
                 vpc_id: str,
                 subnet_id: str,
                 availability_zone: str,
                 ssh_key_name: str,
                 instance_ami_id: str,
                 instance_type: str,
                 security_group_name: str,
                 app_name: str,
                 cluster_name: str,
                 environment_name: str,
                 role_tag: str,
                 remark: str,
                 root_volume_size: int,
                 instance_name: str,
                 **kwargs) -> None:
        super().__init__(scope, id, **kwargs)

        # Reference the existing VPC using from_vpc_attributes
        vpc = ec2.Vpc.from_vpc_attributes(self, "VPC",
            vpc_id=vpc_id,
            availability_zones=[availability_zone],
            public_subnet_ids=[subnet_id]
        )

        # Create Security Group
        security_group = ec2.SecurityGroup(
            self, "EC2ServerSecurityGroup",
            vpc=vpc,
            security_group_name=security_group_name,
            description="EC2 Server Security Group",
            allow_all_outbound=True,
        )

        # Add tags to the Security Group
        Tags.of(security_group).add("Name", security_group_name)
        Tags.of(security_group).add("appname", app_name)
        Tags.of(security_group).add("environment", environment_name)
        Tags.of(security_group).add("remarks", remark)

        # Add Ingress Rules to the Security Group
        security_group.add_ingress_rule(
            peer=ec2.Peer.any_ipv4(),
            connection=ec2.Port.tcp(22),
            description="Allow SSH access from anywhere",
        )
        security_group.add_ingress_rule(
            peer=ec2.Peer.any_ipv4(),
            connection=ec2.Port.tcp(80),
            description="Allow HTTP access from anywhere",
        )

        # Create an IAM role with the AmazonSSMFullAccess policy
        ssm_role = iam.Role(
            self, "SSMRole",
            assumed_by=iam.ServicePrincipal("ec2.amazonaws.com"),
            description="Role for EC2 instance to access AWS Systems Manager",
        )
        ssm_role.add_managed_policy(
            iam.ManagedPolicy.from_aws_managed_policy_name("AmazonSSMFullAccess")
        )

        # Create an instance profile for the IAM role
        instance_profile = iam.InstanceProfile(
            self, "InstanceProfile",
            role=ssm_role,
            instance_profile_name=f"{ssm_role.role_name}-InstanceProfile",
        )

        # Create EC2 Instance
        instance = ec2.Instance(
            self, "EC2Instance",
            instance_type=ec2.InstanceType(instance_type),
            machine_image=ec2.MachineImage.generic_linux({self.node.scope.region: instance_ami_id}),
            vpc=vpc,
            vpc_subnets=ec2.SubnetSelection(subnets=[vpc.public_subnets[0]]),
            security_group=security_group,
            key_name=ssh_key_name,
            instance_profile=instance_profile,
            block_devices=[
                ec2.BlockDevice(
                    device_name="/dev/xvda",
                    volume=ec2.BlockDeviceVolume.ebs(
                        volume_size=root_volume_size,
                        encrypted=True,
                        volume_type=ec2.EbsDeviceVolumeType.GP3,
                        delete_on_termination=True,
                    ),
                )
            ],
        )

        # Add tags to the EC2 Instance
        Tags.of(instance).add("Name", instance_name)
        Tags.of(instance).add("appname", app_name)
        Tags.of(instance).add("cluster", cluster_name)
        Tags.of(instance).add("environment", environment_name)
        Tags.of(instance).add("role", role_tag)
        Tags.of(instance).add("starttime", "na")
        Tags.of(instance).add("stoptime", "na")
        Tags.of(instance).add("created_by", "uipl")

        # Outputs
        CfnOutput(
            self, "InstanceId",
            value=instance.instance_id,
            description="Instance ID of the EC2 instance",
        )
        CfnOutput(
            self, "SecurityGroupId",
            value=security_group.security_group_id,
            description="Security Group ID of the EC2 instance",
        )
        CfnOutput(
            self, "InstanceProfileArn",
            value=instance_profile.instance_profile_arn,
            description="ARN of the instance profile",
        )