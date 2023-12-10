# Access control lists for subnets.
# No custom restriction at the moment, but I'll leave this here
# for 2 reasons:
#  1) - Do not use the default assignment from AWS
#  2) - Leave it ready for customization in case I need it. 
resource "aws_network_acl" "main_acl" {
  vpc_id = aws_vpc.main.id

  subnet_ids = local.private_and_pub_subnet_ids
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${var.project_name}-main-acl"
  }
}

locals {
  private_and_pub_subnet_ids =  concat([for subnet in aws_subnet.private : subnet.id], [for subnet in aws_subnet.public : subnet.id])
}