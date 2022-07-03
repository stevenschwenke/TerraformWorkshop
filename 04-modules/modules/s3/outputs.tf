output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}

output "versioning_enabled" {
  value = var.versioning_enabled
}

output "encryption_enabled" {
  value = var.encryption_enabled
}