module "mysg" {
  source = "./modules/securityGroup/"
  vpc-id = var.vpc-id
}

module "mylt" {
  source = "./modules/launchTemplate/"
  sg-id = module.mysg.sg_id
  iam_inst_prof = var.iam_inst_prof
}

module "myasg" {
  source = "./modules/asg/"
  lt-id = module.mylt.lt_id
  subnet-id = var.subnet-id
  lb_tg_arn = module.mylb.lb_tg_arn
}

module "mylb" {
  source = "./modules/lb/"
  vpc-id = var.vpc-id
  subnet-id = var.subnet-id
  sg-id = module.mysg.sg_id
}