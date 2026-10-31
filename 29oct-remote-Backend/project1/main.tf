#This is an aws configuration file
provider "aws" {
  region = "us-east-1"
}

#Create an ec2 instance
resource "aws_instance" "prod_instance" {
    ami = "ami-0ed59cbb87dfa8dba"
    instance_type = "t3.micro"
    key_name = "pratice"
    count = 1
    
    tags = {
        Name="TestServer"
    }
}