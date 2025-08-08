resource "aws_cloudwatch_log_group" "z_strapi_logs" {
  name              = "/ecs/z-task12-strapi"
  retention_in_days = 7
}
