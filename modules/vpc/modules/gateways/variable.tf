variable "vpc-id" {
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