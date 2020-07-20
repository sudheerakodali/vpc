//for cidr block range

variable "cidr_range" {
    type = list
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24","10.0.4.0/24","10.0.5.0/24"]

}

//for subnets

variable "subnets" {
    type = string
    default = ["subnet1", "subnet2","subnet3","subnet4","subnet5"]

}
