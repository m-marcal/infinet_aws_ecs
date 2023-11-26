resource "aws_ecs_cluster" "cluster" {
  name = var.ecs_cluster_name
}


resource "aws_ecs_task_definition" "task" {
  family                   = "${var.project_name}-ecs-task-top-imdb-100"
  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_execution_role.arn

  container_definitions    = jsonencode([{
    name   = var.container_name
    image  = "${aws_ecr_repository.repository.repository_url}:latest"
    memory = 512,
    cpu    = 100,
    essential = true
    portMappings = [{
      hostPort = 0
      containerPort = 5000
      protocol      = "tcp"
    }]
    environment = [
      { name = "TIMDb_API_KEY", value = var.TIMDb_API_KEY }
    ]
  }])

}

resource "aws_ecs_service" "service" {
  name            = "${var.project_name}-ecs-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "EC2"
  iam_role        = aws_iam_role.ecs_execution_role.name
  desired_count = 2
  
  depends_on = [aws_iam_role.ecs_execution_role]

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

}