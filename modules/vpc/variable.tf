variable "cidr" {
    type = "string"
    default = "0.0.0.0/0"
}

variable "priv_cidr"{
    type = list
    default = []
}

variable "azs" {
    type = list
    default = []
}
