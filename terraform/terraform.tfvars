vpc_id = "vpc-065cf6d69ad9fbf22"

subnet_ids = [
  "subnet-0dc58017a9436f23d", # a
  "subnet-0da2d6106d23b40c7", # b
  "subnet-086c3ae98cdde3671"  # c
]

ecs_security_group_ids = [
  "sg-07fda813b40774326",
  "sg-0c9c61df5971e3414"
]

alb_security_group_id = "sg-0c9c61df5971e3414"

container_image = "zayn63/strapi-task10:latest"

rds_host     = "z-task9-db.cluster-czvkm7xxx.eu-north-1.rds.amazonaws.com"
rds_name     = "strapidb"
rds_username = "strapiadmin"
rds_password = "yourSecurePassword123!"
