variable "bucket_name" {
  description = "Name of the bucket"
  type = string
}

variable "versioning_enabled" {
  description = "Bucket versioning enabled"
  type = bool
  default = true
}

variable "encryption_enabled" {
  description = "Bucket encryption enabled"
  type = bool
  default = true
}