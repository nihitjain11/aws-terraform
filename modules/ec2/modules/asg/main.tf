resource "aws_autoscaling_group" "asg" {

  name = "terraform-asg"

  vpc_zone_identifier = var.subnet-id
  max_size           = 3
  desired_capacity   = 2
  min_size           = 2
  termination_policies=["OldestInstance"]

  launch_template {
    id      = var.lt-id
    version = "$Latest"
  }

  target_group_arns = [var.lb_tg_arn]
}

resource "aws_autoscaling_policy" "asp" {
  name                   = "terraform-asp"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_autoscaling_attachment" "asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  alb_target_group_arn   = var.lb_tg_arn
}