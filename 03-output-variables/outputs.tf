output "subnet_arn" {
  description = "ARN of subnet"
  value = aws_subnet.subnet-1.arn
}

output "vpc_arn" {
  description = "ARN of vpc"
  value = aws_vpc.vpc-1.arn
}

output "subnet_tags" {
  description = "Tags of subnet"
  value = aws_subnet.subnet-1.tags
}

output "vpc_tags" {
  description = "Tags of vpc"
  value = aws_vpc.vpc-1.tags
}