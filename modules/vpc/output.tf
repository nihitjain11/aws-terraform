output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "subnet_id" {
  value = module.mysubnet.subnet_id
}
