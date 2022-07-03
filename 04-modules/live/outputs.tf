output "bucket_arn" {
  value = module.s3_bucket.bucket_arn
}

output "versioning_enabled" {
  value = module.s3_bucket.versioning_enabled
}

output "encryption_enabled" {
  value = module.s3_bucket.encryption_enabled
}