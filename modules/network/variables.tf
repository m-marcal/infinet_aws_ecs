variable "project_name" {
  description = "The project name to be used as a prefix for resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  type = map(object({
    cidr_block = string
    av_zone = string
  }))

  default = {
    public_subnet_1 = {
      cidr_block = "10.0.1.0/24"
      av_zone = "us-east-1a"
    }

    public_subnet_2 = {
      cidr_block = "10.0.2.0/24"
      av_zone = "us-east-1b"
    }
  }
}

variable "private_subnets" {
  type = map(object({
    cidr_block = string
    av_zone = string
  }))

  default = {
    private_subnet_1 = {
      cidr_block = "10.0.3.0/24"
      av_zone = "us-east-1a"
    }

    private_subnet_2 = {
      cidr_block = "10.0.4.0/24"
      av_zone = "us-east-1b"
    }
  }
}
