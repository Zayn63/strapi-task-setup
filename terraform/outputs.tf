HEAD
output "instance_ip" {
  value = aws_instance.strapi.public_ip
}


output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.z_task10_alb.dns_name
}

output "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
  value       = aws_ecs_cluster.z_task10_cluster.name
}

output "ecs_service_name" {
  description = "Name of the ECS Service"
  value       = aws_ecs_service.z_task10_service.name
}
 1ca6cca (task10)
