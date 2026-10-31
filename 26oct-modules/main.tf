provider "aws" {
    region = "us-east-1"
}

module "developer" {
    source = "./ec2-module"
    aws_ami = "ami-0ed59cbb87dfa8dba"
    instance_count = 1
    key_instance = "t3.micro"
    key_pair = "pratice"
    server_name = "developer"
}

module "tester_server" {
    source = "./ec2-module"
    aws_ami = "ami-0ed59cbb87dfa8dba"
    instance_count = 1
    key_instance = "t3.micro"
    key_pair = "pratice"
    server_name = "tester"
}
