# cdk/cdk/ec2_stack.py

from aws_cdk import Stack
from constructs import Construct
from cdk.constructs.ec2_construct import EC2Construct
from cdk.config import EC2_CONFIG  # Import configuration from config.py in the same directory

class EC2Stack(Stack):
    def __init__(self, scope: Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)

        # Create the EC2 instance using the construct
        ec2_construct = EC2Construct(
            self, "DemoEC2Construct",
            **EC2_CONFIG  # Pass the configuration from config.py
        )