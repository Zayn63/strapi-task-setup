provider "aws" {
  region = "eu-north-1"
}

 HEAD
resource "aws_instance" "strapi" {
  ami                    = "ami-0fe8bec493a81c7da"
  instance_type          = "t3.micro"
  key_name               = "zayn-key"
  vpc_security_group_ids = ["sg-0e0fc6d36b1f4d4ae"]

  user_data = <<-EOF
              #!/bin/bash
              exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

              echo "Updating system..."
              sudo apt update -y

              echo "Installing Docker..."
              sudo apt install -y docker.io

              echo "Starting Docker service..."
              sudo systemctl start docker

              echo "Running Strapi Docker container..."
              sudo docker run -d -p 80:1337 --name strapi ghcr.io/zayn63/strapi:${var.image_tag}

              echo "Deployment complete."
              EOF

  tags = {
    Name = "Strapi-Deployed-Instance"
  }
}

output "instance_public_ip" {
  description = "Public IP of the deployed Strapi instance"
  value       = aws_instance.strapi.public_ip
}

data "aws_db_instance" "z_task9_db" {
  db_instance_identifier = "z-task9-db"
}

resource "aws_ecs_cluster" "z_task10_cluster" {
  name = "z-task10-cluster"
}

resource "aws_iam_role" "z_task10_task_execution_role" {
  name = "z-task10-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "z_task10_execution_role_policy" {
  role       = aws_iam_role.z_task10_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "z_task10_task" {
  family                   = "z-task10-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.z_task10_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = "zayn63/strapi-task10:latest"
      essential = true
      portMappings = [
        {
          containerPort = 1337
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "DATABASE_CLIENT", value = "postgres" },
        { name = "DATABASE_HOST", value = var.rds_host },
        { name = "DATABASE_PORT", value = "5432" },
        { name = "DATABASE_NAME", value = var.rds_name },
        { name = "DATABASE_USERNAME", value = var.rds_username },
        { name = "DATABASE_PASSWORD", value = var.rds_password }
      ]
    }
  ])
}

resource "aws_ecs_service" "z_task10_service" {
  name            = "z-task10-service"
  cluster         = aws_ecs_cluster.z_task10_cluster.id
  task_definition = aws_ecs_task_definition.z_task10_task.arn
  desired_count   = 1

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = var.ecs_security_group_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.z_task10_tg.arn
    container_name   = "strapi"
    container_port   = 1337
  }

 depends_on = [aws_lb_listener.z-task10-listener]

}

resource "aws_lb" "z_task10_alb" {
  name               = "z-task10-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [var.alb_security_group_id]
}

resource "aws_lb_target_group" "z_task10_tg" {
  name     = "z-task10-tg"
  port     = 1337
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/_health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}


