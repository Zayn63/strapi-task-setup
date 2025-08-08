provider "aws" {
  region = "eu-north-1"
}

data "aws_db_instance" "z_task10_db" {
  db_instance_identifier = "z-task9-db"
}

output "z_rds_endpoint" {
  value = data.aws_db_instance.z_task10_db.endpoint
}
