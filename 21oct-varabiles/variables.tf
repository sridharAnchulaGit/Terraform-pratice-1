variable "ami" {
    description = "ami ID"
    type = string
    default = "ami-08c46876c64a927b8"
}

variable "instace_type" {
    description = "aws instance type"
    type = string
    default = "t3.micro"
}

variable "key_pair" {
    description = "select key pair"
    type = string
    default = "pratice"
}

variable "instance_count" {
    description = "no.of instace"
    type = number
    default = 1
  
}

variable "enivernment" {
    description = "instance name"
    type = string
    default = "prod"
}
