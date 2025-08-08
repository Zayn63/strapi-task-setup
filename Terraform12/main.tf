provider "aws" {
  region = "eu-north-1"
}

resource "aws_ecr_repository" "z_task12_ecr" {
  name = "z-task12-ecr"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecs_task_definition" "z_task12" {
  family                   = "z-task12-strapi"
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = "512"
  memory                  = "1024"

  execution_role_arn = aws_iam_role.z_ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.z_ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "strapi"
      image = "${aws_ecr_repository.z_task12_ecr.repository_url}:latest"
      portMappings = [{
        containerPort = 1337
        hostPort      = 1337
      }]
      essential = true
      environment = [
        {
          name  = "DATABASE_CLIENT"
          value = "postgres"
        },
        {
          name  = "DATABASE_HOST"
          value = aws_db_instance.z_task9_db.address
        },
        {
          name  = "DATABASE_PORT"
          value = "5432"
        },
        {
          name  = "DATABASE_NAME"
          value = aws_db_instance.z_task9_db.name
        },
        {
          name  = "DATABASE_USERNAME"
          value = aws_db_instance.z_task9_db.username
        },
        {
          name  = "DATABASE_PASSWORD"
          value = aws_db_instance.z_task9_db.password
        }
      ]
    }
  ])
}

resource "aws_ecs_cluster" "z_task12" {
  name = "z-task12-cluster"
}

resource "aws_ecs_service" "z_task12" {
  name            = "z-task12-service"
  cluster         = aws_ecs_cluster.z_task12.id
  task_definition = aws_ecs_task_definition.z_task12.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [var.ecs_security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.z_task12.arn
    container_name   = "strapi"
    container_port   = 1337
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  depends_on = [aws_lb_listener.z_http]
}
