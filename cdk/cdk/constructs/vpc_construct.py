from constructs import Construct
from aws_cdk import (
    aws_ec2 as ec2,
    CfnOutput,
    Tags
)

class VpcConstruct(Construct):

    def __init__(self, scope: Construct, id: str, *,
                 vpc_cidr: str,
                 public_subnet_cidrs: list,
                 private_app_subnet_cidrs: list,
                 db_subnet_cidrs: list,
                 availability_zones: list,
                 environment: str,
                 **kwargs) -> None:
        super().__init__(scope, id, **kwargs)

        # Create the VPC
        vpc = ec2.CfnVPC(
            self, "Vpc",
            cidr_block=vpc_cidr,
            enable_dns_support=True,
            enable_dns_hostnames=True,
            tags=[{"key": "Name", "value": f"{id}-vpc"}]
        )

        # Add tags to the VPC
        Tags.of(vpc).add("environment", environment)

        # Create public subnets
        public_subnets = []
        for i, cidr in enumerate(public_subnet_cidrs):
            subnet = ec2.CfnSubnet(
                self, f"PublicSubnet{i+1}",
                vpc_id=vpc.ref,
                cidr_block=cidr,
                availability_zone=availability_zones[i % len(availability_zones)],
                tags=[{"key": "Name", "value": f"PublicSubnet{i+1}"}]
            )
            public_subnets.append(subnet)

        # Create private app subnets
        private_app_subnets = []
        for i, cidr in enumerate(private_app_subnet_cidrs):
            subnet = ec2.CfnSubnet(
                self, f"PrivateAppSubnet{i+1}",
                vpc_id=vpc.ref,
                cidr_block=cidr,
                availability_zone=availability_zones[i % len(availability_zones)],
                tags=[{"key": "Name", "value": f"PrivateAppSubnet{i+1}"}]
            )
            private_app_subnets.append(subnet)

        # Create database subnets
        db_subnets = []
        for i, cidr in enumerate(db_subnet_cidrs):
            subnet = ec2.CfnSubnet(
                self, f"DBSubnet{i+1}",
                vpc_id=vpc.ref,
                cidr_block=cidr,
                availability_zone=availability_zones[i % len(availability_zones)],
                tags=[{"key": "Name", "value": f"DBSubnet{i+1}"}]
            )
            db_subnets.append(subnet)

        # Create an Internet Gateway
        igw = ec2.CfnInternetGateway(self, "InternetGateway")
        ec2.CfnVPCGatewayAttachment(
            self, "IGWAttachment",
            vpc_id=vpc.ref,
            internet_gateway_id=igw.ref
        )

        # Create a NAT Gateway in the first public subnet
        eip = ec2.CfnEIP(self, "NatGatewayEIP", domain="vpc")
        nat_gateway = ec2.CfnNatGateway(
            self, "NatGateway",
            allocation_id=eip.attr_allocation_id,
            subnet_id=public_subnets[0].ref
        )

        # Create a public route table
        public_route_table = ec2.CfnRouteTable(
            self, "PublicRouteTable",
            vpc_id=vpc.ref,
            tags=[{"key": "Name", "value": "PublicRouteTable"}]
        )

        # Add a default route to the Internet Gateway in the public route table
        ec2.CfnRoute(
            self, "PublicRoute",
            route_table_id=public_route_table.ref,
            destination_cidr_block="0.0.0.0/0",
            gateway_id=igw.ref
        )

        # Associate public subnets with the public route table
        for i, subnet in enumerate(public_subnets):
            ec2.CfnSubnetRouteTableAssociation(
                self, f"PublicSubnet{i+1}RouteAssociation",
                route_table_id=public_route_table.ref,
                subnet_id=subnet.ref
            )

        # Create a private route table
        private_route_table = ec2.CfnRouteTable(
            self, "PrivateRouteTable",
            vpc_id=vpc.ref,
            tags=[{"key": "Name", "value": "PrivateRouteTable"}]
        )

        # Add a default route to the NAT Gateway in the private route table
        ec2.CfnRoute(
            self, "PrivateRoute",
            route_table_id=private_route_table.ref,
            destination_cidr_block="0.0.0.0/0",
            nat_gateway_id=nat_gateway.ref
        )

        # Associate private subnets with the private route table
        for i, subnet in enumerate(private_app_subnets):
            ec2.CfnSubnetRouteTableAssociation(
                self, f"PrivateAppSubnet{i+1}RouteAssociation",
                route_table_id=private_route_table.ref,
                subnet_id=subnet.ref
            )

        for i, subnet in enumerate(db_subnets):
            ec2.CfnSubnetRouteTableAssociation(
                self, f"DBSubnet{i+1}RouteAssociation",
                route_table_id=private_route_table.ref,
                subnet_id=subnet.ref
            )

        # Outputs
        CfnOutput(
            self, "VpcId",
            value=vpc.ref,
            export_name=f"{id}-VPCID"
        )

        for i, subnet in enumerate(public_subnets):
            CfnOutput(
                self, f"PublicSubnet{i+1}Output",
                value=subnet.ref,
                export_name=f"{id}-PublicSubnet{i+1}"
            )

        for i, subnet in enumerate(private_app_subnets):
            CfnOutput(
                self, f"PrivateAppSubnet{i+1}Output",
                value=subnet.ref,
                export_name=f"{id}-PrivateAppSubnet{i+1}"
            )

        for i, subnet in enumerate(db_subnets):
            CfnOutput(
                self, f"DBSubnet{i+1}Output",
                value=subnet.ref,
                export_name=f"{id}-DBSubnet{i+1}"
            )