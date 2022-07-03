terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.8"
    }
  }
  backend "s3" {
    bucket = "stevenschwenke-terraform-workshop-tf-state-development"
    key = "04-modules/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "tf-locks-development"
    encrypt = true
  }
}

data "aws_caller_identity" "stage" {}

module "s3_bucket" {
  source = "../modules/s3"

  bucket_name = "stevens-cool-bucket-for-terraform-workshop"
  versioning_enabled = false
  encryption_enabled = false
}
