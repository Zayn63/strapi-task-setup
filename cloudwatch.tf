resource "aws_cloudwatch_metric_alarm" "z-task10-cpu-alarm" {
  alarm_name          = "z-task10-CPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarm when CPU exceeds 80%"
  dimensions = {
    ClusterName = aws_ecs_cluster.z-task10-cluster.name
    ServiceName = aws_ecs_service.z-task10-service.name
  }
}

resource "aws_cloudwatch_metric_alarm" "z-task10-memory-alarm" {
  alarm_name          = "z-task10-MemoryUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarm when Memory exceeds 80%"
  dimensions = {
    ClusterName = aws_ecs_cluster.z-task10-cluster.name
    ServiceName = aws_ecs_service.z-task10-service.name
  }
}

resource "aws_cloudwatch_log_group" "z-task10-log-group" {
  name              = "/ecs/z-task10"
  retention_in_days = 7
}
