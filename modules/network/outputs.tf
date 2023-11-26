output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "List of availalbe public VPCs connected to the VPC Internet Gateway"
  value       = [for subnet in aws_subnet.public : subnet.id]
}