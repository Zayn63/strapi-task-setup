
variable "image_tag" {
  description = "Docker image tag"
  type        = string
}


variable "container_image" {
  description = "Docker image for the ECS container"
  type        = string
}

variable "ecs_security_group_ids" {
  description = "Security group IDs to associate with ECS service"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group ID for the Application Load Balancer"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for ECS tasks and load balancer"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where resources are deployed"
  type        = string
}

variable "rds_host" {
  description = "Database host address"
  type        = string
}

variable "rds_name" {
  description = "Database name"
  type        = string
}

variable "rds_username" {
  description = "Database username"
  type        = string
}

variable "rds_password" {
  description = "Database password"
  type        = string
}

