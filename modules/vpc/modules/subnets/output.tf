output "subnet_id" {
  value = aws_subnet.public.*.id #concat(aws_subnet.private.*.id,aws_subnet.public.*.id)
}
