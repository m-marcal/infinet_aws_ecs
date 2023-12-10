resource "aws_subnet" "public" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.av_zone
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${each.key}"
  }
}


# Ressources from Private subnets will connect to the
# Internet using NAT gateways, so I'll block public ip mapping
# by default. 
resource "aws_subnet" "private" {
  for_each = var.private_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.av_zone
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${each.key}"
  }
}