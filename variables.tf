variable "aws_region" {
  description = "AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "The project name to be used as a prefix for resources"
  type        = string
  default     = "infnet"
}

variable "TIMDb_API_KEY" {
  description = "API Key for TIMDb"
  type        = string
}
