vpc_id             = "vpc-065cf6d69ad9fbf22"
subnet_ids         = ["subnet-0da2d6106d23b40c7", "subnet-0dc58017a9436f23d", "subnet-086c3ae98cdde3671"]
security_group_ids = ["sg-07fda813b40774326", "sg-0c9c61df5971e3414"]

docker_image       = "zayn63/strapi-task10:latest"
container_port     = 1337

ecs_cluster_name   = "z-task10-cluster"
task_family        = "z-task10-taskdef"
service_name       = "z-task10-service"

alb_name           = "z-task10-alb"
alb_target_name    = "z-task10-target-group"
alb_listener_name  = "z-task10-listener"

rds_endpoint       = "z-task9-db.<your-db-id>.eu-north-1.rds.amazonaws.com"  # Replace with actual endpoint if needed
rds_port           = 5432
rds_username       = "strapi"
rds_password       = "strapi123"
rds_database       = "strapidb"
