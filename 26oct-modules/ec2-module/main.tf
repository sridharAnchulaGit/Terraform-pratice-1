provider "aws" {
    region = "us-east-1"
}

#creating ec2 instance
resource "aws_instance" "devloper" {
    ami = var.aws_ami
    key_name = var.key_pair
    instance_type =var.key_instance
    count =var.instance_count
    tags = {
      Name = var.server_name
    }
}