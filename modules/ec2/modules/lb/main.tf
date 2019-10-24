################
# target group #
################

resource "aws_lb_target_group" "tg" {
  name = "mytargets"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-id
  depends_on = [aws_lb.lb]
}


################
# loadbalancer #
################

resource "aws_lb" "lb" {
  name = "tf-lb-nihit"
  load_balancer_type = "application"
  security_groups    = [var.sg-id]
  subnets            = var.subnet-id

  #enable_deletion_protection = true
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}