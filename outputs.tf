output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.z-task10-alb.dns_name
}

output "strapi_service_name" {
  description = "ECS Service name"
  value       = aws_ecs_service.z-task10-service.name
}

output "strapi_cluster_name" {
  description = "ECS Cluster name"
  value       = aws_ecs_cluster.z-task10-cluster.name
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = data.aws_db_instance.z-task10-db.endpoint
}
