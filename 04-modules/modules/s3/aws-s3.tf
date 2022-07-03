resource "aws_s3_bucket" "bucket" {

  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}

# Explicitly block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# version all changes
resource "aws_s3_bucket_versioning" "versioning_example" {

  # Enable versioning if this is configured, else do not create this resource
  count = var.versioning_enabled ? 1 : 0

  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {

  # Enable encryption if this is configured, else do not create this resource
  count = var.encryption_enabled ? 1 : 0

  bucket = aws_s3_bucket.bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}