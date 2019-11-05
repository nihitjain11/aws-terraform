resource "aws_ecs_service" "serv" {
  name            = "WP-MySQL" #"webserver" 
  cluster         = var.clust-id
  task_definition = var.taskdef-arn
  desired_count   = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent = 200

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  load_balancer {
    target_group_arn = var.lb_tg_arn
    container_name   = "wp" #"web"
    container_port   = 80
  }
}