resource "aws_ecs_cluster" "mycluster" {
  name = "terraform"
}

module "myservice" {
  source = "./modules/service/"
  clust-id = aws_ecs_cluster.mycluster.id
  taskdef-arn = module.mytaskdef.taskdef_arn
  lb_tg_arn = var.lb_tg_arn
}

module "mytaskdef" {
  source = "./modules/taskdef/" 
}