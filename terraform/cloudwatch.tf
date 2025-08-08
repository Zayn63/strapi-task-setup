resource "aws_cloudwatch_log_group" "z-task10-log-group" {
  name              = "/ecs/z-task10"
  retention_in_days = 7
}
