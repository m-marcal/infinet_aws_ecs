resource "aws_security_group" "alb_sg" {
  name        = "lb-sg"
  description = "Security group for the app. load balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-alb_sg"
  }


  # Allow inbound HTTP traffic from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecs_instances_sg" {
  name        = "ecs-instances-sg"
  description = "Security group for ECS instances"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-ecs_instances_sg"
  }

  # Allow inbound traffic from Load Balancer on the ECS Service port
  ingress {
    description     = "Allow ingress traffic from ALB on HTTP on ephemeral ports"
    from_port       = 1024
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
