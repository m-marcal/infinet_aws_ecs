resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Public IPs for NAT gateways
resource "aws_eip" "elastic_ip" {
  for_each = var.public_subnets
  domain      = "vpc"

  tags = {
    Name = "${var.project_name}-eip-nat-gw-${each.key}"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  for_each      = var.public_subnets
  subnet_id     = aws_subnet.public[each.key].id
  allocation_id = aws_eip.elastic_ip[each.key].id

  tags = {
    Name = "${var.project_name}-nat-gw-${each.key}"
  }
}