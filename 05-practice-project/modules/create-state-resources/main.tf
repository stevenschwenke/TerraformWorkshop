terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.8"
    }
  }
  backend "s3" {
    bucket = "stevenschwenke-terraform-workshop-tf-state-development"
    key = "modules/create-state-resources/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "tf-locks-development"
    encrypt = true
  }
}

data "aws_caller_identity" "stage" {}

locals {
  account_id = data.aws_caller_identity.stage.account_id
}
