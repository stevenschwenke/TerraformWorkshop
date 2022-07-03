output "s3_arn" {
  description = "ARN of S3 bucket"
  value = aws_s3_bucket.terraform_state.arn
}

output "s3_tags" {
  description = "Tags of S3 bucket"
  value = aws_s3_bucket.terraform_state.tags
}

output "dynamo_arn" {
  description = "ARN of DynamoDB"
  value = aws_dynamodb_table.terraform_locks.arn
}

output "dynamo_tags" {
  description = "Tags of DynamoDB"
  value = aws_dynamodb_table.terraform_locks.tags
}

output "account_id" {
  value = local.account_id
}
