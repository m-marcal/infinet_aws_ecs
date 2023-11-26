data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")

  vars = {
    ecs_cluster_name = var.ecs_cluster_name
  }
}

resource "aws_launch_template" "ec2_launch_template" {
  depends_on = [aws_iam_role.ecs_execution_role]

  name_prefix   = "${var.project_name}-launch-template-"
  image_id      = var.ecs_optimized_ami 
  instance_type = var.ecs_ec2_instance_type
  key_name      = var.ssh_key_name
  
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_role_profile.name
  }

  vpc_security_group_ids = [aws_security_group.ecs_instances_sg.id]

  user_data = base64encode(data.template_file.user_data.rendered)

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-ec2-instance"
    }
  }
}