provider "aws" {
    region = "us-east-1"
    version = "~> v2.0"
}

terraform {
  backend "s3"{
    bucket = "terraform-devops-bootcamp"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}

module "myvpc" {
  source = "./modules/vpc/"

  cidr = "10.0.0.0/16"

  priv_cidr = ["10.0.1.0/24","10.0.2.0/24"]
  pub_cidr = ["10.0.3.0/24","10.0.4.0/24"]
  azs = ["us-east-1a","us-east-1b"]

}