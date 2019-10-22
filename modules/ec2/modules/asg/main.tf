resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = var.subnet-id
  desired_capacity   = 1
  max_size           = 2
  min_size           = 0
  termination_policies=["OldestInstance"]

  launch_template {
    id      = var.lt-id
    version = "$Latest"
  }
}