terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.8"
    }
  }

  # Use the already-existing backend from 04-modules:
  backend "s3" {
    bucket = "stevenschwenke-terraform-workshop-tf-state-development"
    key = "04-modules/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "tf-locks-development"
    encrypt = true
  }
}

module "ecr" {
  source = "../../../modules/ecr"
}