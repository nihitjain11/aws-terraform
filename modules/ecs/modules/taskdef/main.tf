resource "aws_ecs_task_definition" "task" {
  family                    = "webserver" #"WP-MySQL"
  network_mode              = "bridge"
  requires_compatibilities  = ["EC2"]

  cpu = 256
  memory = 256

  # volume {
  #   name      = "mysql"
  #   host_path = "/data"
  # }

  container_definitions = "${file("${path.module}/nginx.json")}"#"${file("${path.module}/WP-MySQL.json")}"
}