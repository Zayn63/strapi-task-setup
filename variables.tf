variable "vpc_id" {
  default = "vpc-065cf6d69ad9fbf22"
}

variable "subnet_ids" {
  type    = list(string)
  default = [
    "subnet-0dc58017a9436f23d",
    "subnet-0da2d6106d23b40c7",
    "subnet-086c3ae98cdde3671"
  ]
}

variable "security_group_ids" {
  type    = list(string)
  default = [
    "sg-07fda813b40774326",
    "sg-0c9c61df5971e3414"
  ]
}

variable "strapi_image" {
  default = "zayn63/strapi-task10:latest"
}

variable "aws_region" {
  default = "eu-north-1"
}
