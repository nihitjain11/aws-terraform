resource "aws_launch_template" "lt" {

  image_id = "ami-04b9e92b5572fa0d1"

   instance_type = "t2.micro"

  # network_interfaces {
  #   associate_public_ip_address = true
  # }

  vpc_security_group_ids = [var.sg-id]
}
