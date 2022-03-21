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

# Create an EC2
resource "aws_instance" "my-instance" {
  # Ubuntu Server 20.04 LTS
  ami = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  tags = {
    Name = "my-instance"
  }
}

