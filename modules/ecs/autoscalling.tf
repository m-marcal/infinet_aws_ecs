resource "aws_autoscaling_group" "asg" {
  desired_capacity     = var.asg_desired_capacity
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  vpc_zone_identifier  = var.priv_subnet_ids
  health_check_type     = "EC2"

  launch_template {
    id      = aws_launch_template.ec2_launch_template.id
    version = "$Latest"
  }
  
  tag {
    key                 = "Name"
    value               = "${var.project_name}-asg"
    propagate_at_launch = true
  }
}

# Associate ALB to AutoScaling Group
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn   = aws_lb_target_group.target_group.arn
}