resource "aws_ecs_cluster" "main" {
  name = "${var.prefix}-cluster-${var.environment}"
}

resource "aws_ecs_task_definition" "main" {
  family                   = "${var.prefix}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([{
    name      = "${var.prefix}-container-${var.environment}"
    image     = var.app_image
    essential = true
    #    environment = var.container_environment
    portMappings = [{
      protocol      = "tcp"
      containerPort = var.app_port
      hostPort      = var.app_port
    }]
  }])
  # container_definitions = templatefile("${path.module}/templates/container_definitions_ec2_dynamic.tpl", {
  # name      = "${var.prefix}-container-${var.environment}"
  #     cpu    = 250
  #     memory = 500
  #     image  = var.app_image
  #     # environmentFiles    = "${var.environment_file_path}"
  #     container_port      = var.app_port
  # })
}

resource "aws_ecs_service" "main" {
  name            = "${var.prefix}-service-${var.environment}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.public.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.main.id
    container_name   = "${var.prefix}-container-${var.environment}"
    container_port   = var.app_port
  }

  # depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
  # depends_on = [aws_alb_listener.https, aws_iam_role_policy_attachment.ecs_task_execution_role]

}