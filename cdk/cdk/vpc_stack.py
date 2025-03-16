# cdk/cdk/vpc_stack.py

from aws_cdk import Stack
from constructs import Construct
from cdk.constructs.vpc_construct import VpcConstruct
from cdk.config import VPC_CONFIG  # Import configuration from config.py

class VpcStack(Stack):

    def __init__(self, scope: Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)

        # Create the VPC using the construct
        vpc_construct = VpcConstruct(
            self, "DemoVpcConstruct",
            **VPC_CONFIG  # Pass the configuration from config.py
        )