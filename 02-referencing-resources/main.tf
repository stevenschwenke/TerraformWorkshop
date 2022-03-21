terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"

  access_key = "your-access-key"
  secret_key = "your-secret-key"

}

# Create a VPC and subnet
resource "aws_vpc" "vpc-1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "production "
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.vpc-1.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "prod-subnet"
  }
}