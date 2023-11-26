output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.network.vpc_id
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = module.ecs.repository_url
}

output "load_balancer_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.ecs.load_balancer_dns_name
}