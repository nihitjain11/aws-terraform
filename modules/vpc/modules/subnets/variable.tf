variable "private_subnets" {
    type = list
    default = []
}
variable "azs" {
    type = list
    default = []
}

variable "vpc-id" {
    type = string
    default = ""
}
