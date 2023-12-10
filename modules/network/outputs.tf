output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "List of public subnets"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnets" {
  description = "List of private subnets"
  value       = [for subnet in aws_subnet.private : subnet.id]
}