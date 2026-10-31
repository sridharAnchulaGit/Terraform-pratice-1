
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.81.0.0/16"
}

variable "subnet_cidr" {
  description = "Subnet CIDR block"
  type        = string
  default     = "10.81.3.0/24"
}

variable "eni_pvt_ip" {
  description = "Private IP address for the network interface"
  type        = list(string)
  default     = ["10.81.3.33"]
}

variable "ami" {
  description = "EC2 AMI ID for us-east-1"
  type        = string
  default     = "ami-0567589d25e06853e"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_pair" {
  description = "Existing AWS EC2 key pair name"
  type        = string
  default     = "pratice"
}

variable "srv_name" {
  description = "EC2 server name"
  type        = string
  default     = "dev-srv"
}
