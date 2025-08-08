resource "aws_lb" "z-task10-alb" {
  name               = "z-task10-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "z-task10-target-group" {
  name     = "z-task10-tg"
  port     = 1337
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  target_type = "ip"
}

resource "aws_lb_listener" "z-task10-listener" {
  load_balancer_arn = aws_lb.z-task10-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.z-task10-target-group.arn
  }
}
