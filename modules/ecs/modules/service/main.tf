resource "aws_ecs_service" "serv" {
  name            = "webserver"#"WP-MySQL"
  cluster         = var.clust-id
  task_definition = var.taskdef-arn
  desired_count   = 2
  #iam_role        = aws_iam_role.ecsInstanceRole
  #depends_on      = ["aws_iam_role_policy.ecs"]
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
    container_name   = "web" #"wp"
    container_port   = 80
  }
}