output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.z-task12-alb.dns_name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.z-task12-service.name
}

output "code_deploy_app" {
  description = "CodeDeploy application name"
  value       = aws_codedeploy_app.z-task12-app.name
}
