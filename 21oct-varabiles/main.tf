resource "aws_instance" "prod" {
    ami = var.ami
    instance_type = var.instace_type
    count = var.instance_count
    key_name = var.key_pair
    tags = {
      Name= var.enivernment
    }
}