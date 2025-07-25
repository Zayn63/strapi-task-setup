terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "vpc" {
  source = "./modules/vpc"

  aws_region            = var.aws_region
  vpc_name              = var.vpc_name
  vpc_cidr              = var.vpc_cidr
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
}



module "ecs" {
  source           = "./modules/ecs"
  vpc_id           = module.vpc.vpc_id
  public_subnets   = module.vpc.public_subnets
  aws_region       = var.aws_region
  strapi_image     = var.strapi_image