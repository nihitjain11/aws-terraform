provider "aws" {
    region = "us-east-1"
    version = "~> v2.0"
}

# terraform {
#   backend "s3"{
#     bucket = "terraform-devops-bootcamp"
#     key = "terraform.tfstate"
#     region = "us-east-1"
#   }
# }

module "myvpc" {
  source = "./modules/vpc/"

  cidr = "10.0.0.0/16"

  priv_cidr = var.priv_cidr
  pub_cidr = var.pub_cidr
  azs = var.azs

}

module "myec2" {
  source = "./modules/ec2/"

  vpc-id = module.myvpc.vpc_id
  subnet-id = module.myvpc.subnet_id
  iam_inst_prof = module.myiam.inst-profile
}

module "myecs" {
  source = "./modules/ecs/"
  lb_tg_arn = module.myec2.lb_tg_arn
}

module "myiam" {
  source = "./modules/iam/"
}