module "mysg" {
  source = "./modules/securityGroup/"
  vpc-id = var.vpc-id
}

module "mylt" {
  source = "./modules/launchTemplate/"
  sg-id = module.mysg.sg_id
}

module "myasg" {
  source = "./modules/asg/"
  lt-id = module.mylt.lt_id
  subnet-id = var.subnet-id
}
