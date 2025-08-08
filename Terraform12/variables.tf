variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-065cf6d69ad9fbf22"
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
  default     = ["subnet-0dc58017a9436f23d", "subnet-0da2d6106d23b40c7", "subnet-086c3ae98cdde3671"]
}

variable "ecs_security_group_id" {
  description = "Security Group ID for ECS"
  type        = string
  default     = "sg-07fda813b40774326"
}

variable "alb_security_group_id" {
  description = "Security Group ID for ALB"
  type        = string
  default     = "sg-0c9c61df5971e3414"
}

variable "docker_image_tag" {
  description = "Docker image tag (usually commit SHA)"
  type        = string
  default     = "latest"
}
