terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Define variables for AWS credentials. Provide with env variables!
# export TF_VAR_access_key=your_access_key
variable "access_key" {
  description = "Access key from AWS IAM"
  type        = string
  sensitive   = true
}

# export TF_VAR_secret_key=your_secret_key
variable "secret_key" {
  description = "Secret key from AWS IAM"
  type        = string
  sensitive   = true
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"

  access_key = var.access_key
  secret_key = var.secret_key

}

# Create a VPC and subnet
resource "aws_vpc" "vpc-1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "production"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.vpc-1.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "prod-subnet"
  }
}
