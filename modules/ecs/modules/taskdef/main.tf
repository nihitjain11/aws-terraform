resource "aws_ecs_task_definition" "task" {
  family                    = "WP-MySQL" #"webserver"
  network_mode              = "bridge"
  requires_compatibilities  = ["EC2"]

  cpu = 512
  memory = 512

  volume {
    name      = "mysql"
    host_path = "/data"
  }

  container_definitions = "${file("${path.module}/WP-MySQL.json")}" #"${file("${path.module}/nginx.json")}"
}