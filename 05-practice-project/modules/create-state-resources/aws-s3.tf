resource "aws_s3_bucket" "terraform_state" {

  bucket = "stevenschwenke-terraform-workshop-tf-state-development"

  # don't delete this bucket when running "terraform destroy"
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "tf-state-development"
  }
}

# Explicitly block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# version all changes
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.terraform_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}