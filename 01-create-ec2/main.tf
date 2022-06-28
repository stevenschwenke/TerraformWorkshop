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

# Create an EC2
resource "aws_instance" "my-instance" {
  # Ubuntu Server 20.04 LTS
  ami = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  tags = {
    Name = "my-instance"
  }
}

