resource "aws_ecs_cluster" "z-task10-cluster" {
  name = "z-task10-cluster"
}

resource "aws_ecs_task_definition" "z-task10-task" {
  family                   = "z-task10-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.z-task10-execution-role.arn
  task_role_arn            = aws_iam_role.z-task10-execution-role.arn

  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = 1337
          hostPort      = 1337
        }
      ]
      environment = [
        { name = "DATABASE_CLIENT", value = "postgres" },
        { name = "DATABASE_HOST",   value = var.rds_host },
        { name = "DATABASE_PORT",   value = "5432" },
        { name = "DATABASE_NAME",   value = var.rds_name },
        { name = "DATABASE_USERNAME", value = var.rds_username },
        { name = "DATABASE_PASSWORD", value = var.rds_password }
      ]
    }
  ])
}

resource "aws_ecs_service" "z-task10-service" {
  name            = "z-task10-service"
  cluster         = aws_ecs_cluster.z-task10-cluster.id
  task_definition = aws_ecs_task_definition.z-task10-task.arn
  desired_count   = 1

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [var.alb_security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.z-task10-target-group.arn
    container_name   = "strapi"
    container_port   = 1337
  }

  depends_on = [
    aws_lb_listener.z-task10-listener
  ]
}

