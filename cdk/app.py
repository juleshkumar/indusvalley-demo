# cdk/app.py

#!/usr/bin/env python3
import aws_cdk as cdk
from cdk.vpc_stack import VpcStack
from cdk.ec2_stack import EC2Stack

app = cdk.App()

# Define the environment (account and region)
env = cdk.Environment(
    account="423623866361",  # Replace with your AWS account ID
    region="ap-south-1"      # Replace with your AWS region
)

# Create the VPC Stack
vpc_stack = VpcStack(app, "VpcStack", env=env)

# Create the EC2 Stack
ec2_stack = EC2Stack(app, "EC2Stack", env=env)

app.synth()