######################
# main.tf
######################

provider "aws" {
  region = "eu-north-1"
}

resource "aws_ecs_cluster" "z_task10_cluster" {
  name = "z-task10-cluster"
}

resource "aws_iam_role" "z_task10_ecs_task_execution_role" {
  name = "z-task10-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.z_task10_assume_role_policy.json
}

data "aws_iam_policy_document" "z_task10_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "z_task10_ecs_task_execution_policy" {
  role       = aws_iam_role.z_task10_ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_lb" "z_task10_alb" {
  name               = "z-task10-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-07fda813b40774326", "sg-0c9c61df5971e3414"]
  subnets            = [
    "subnet-0dc58017a9436f23d",
    "subnet-0da2d6106d23b40c7",
    "subnet-086c3ae98cdde3671"
  ]
}

resource "aws_lb_target_group" "z_task10_tg" {
  name     = "z-task10-tg"
  port     = 1337
  protocol = "HTTP"
  vpc_id   = "vpc-065cf6d69ad9fbf22"
  target_type = "ip"
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "z_task10_listener" {
  load_balancer_arn = aws_lb.z_task10_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.z_task10_tg.arn
  }
}

resource "aws_ecs_task_definition" "z_task10_task" {
  family                   = "z-task10-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.z_task10_ecs_task_execution_role.arn
  container_definitions    = jsonencode([
    {
      name      = "strapi"
      image     = "zayn63/strapi-task10:latest"
      essential = true
      portMappings = [
        {
          containerPort = 1337
          hostPort      = 1337
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "DATABASE_CLIENT"
          value = "postgres"
        },
        {
          name  = "DATABASE_HOST"
          value = aws_db_instance.z_task10_db.address
        },
        {
          name  = "DATABASE_PORT"
          value = "5432"
        },
        {
          name  = "DATABASE_NAME"
          value = aws_db_instance.z_task10_db.name
        },
        {
          name  = "DATABASE_USERNAME"
          value = aws_db_instance.z_task10_db.username
        },
        {
          name  = "DATABASE_PASSWORD"
          value = aws_db_instance.z_task10_db.password
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "z_task10_service" {
  name            = "z-task10-service"
  cluster         = aws_ecs_cluster.z_task10_cluster.id
  task_definition = aws_ecs_task_definition.z_task10_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [
      "subnet-0dc58017a9436f23d",
      "subnet-0da2d6106d23b40c7",
      "subnet-086c3ae98cdde3671"
    ]
    assign_public_ip = true
    security_groups  = ["sg-07fda813b40774326", "sg-0c9c61df5971e3414"]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.z_task10_tg.arn
    container_name   = "strapi"
    container_port   = 1337
  }
  depends_on = [aws_lb_listener.z_task10_listener]
}
