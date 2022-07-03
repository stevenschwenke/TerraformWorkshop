resource "aws_dynamodb_table" "terraform_locks" {
  name = "tf-locks-development"
  billing_mode = "PAY_PER_REQUEST"
  point_in_time_recovery {
    enabled = true
  }
  hash_key = "LockID"
  server_side_encryption {
    enabled = true
  }
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "tf-locks-development"
  }
}