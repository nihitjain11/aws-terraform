variable "vpc-id" {
    type = string
    default = ""
}
variable "nat_id" {
    type = string
    default = ""
}
variable "igw_id" {
    type = string
    default = ""
}
variable "priv_subnets" {
    type = list
    default = []
}
variable "pub_subnets" {
    type = list
    default = []
}