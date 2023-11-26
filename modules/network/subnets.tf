resource "aws_subnet" "public" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.av_zone
  map_public_ip_on_launch = true #to-do change this to NAT gateways

  tags = {
    Name = "${var.project_name}-${each.key}"
  }
}