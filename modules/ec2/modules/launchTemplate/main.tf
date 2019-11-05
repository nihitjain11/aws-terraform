resource "aws_launch_template" "lt" {

  image_id = "ami-0f846c06eb372f19a" #ami for ecs

  instance_type = "t2.micro"

  vpc_security_group_ids = [var.sg-id]
  key_name = "nihitjain11"
  user_data = filebase64("${path.module}/ecs.sh")
  iam_instance_profile {
    name = var.iam_inst_prof
  }
}
