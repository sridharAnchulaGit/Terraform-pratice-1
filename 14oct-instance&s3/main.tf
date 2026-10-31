terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.69.1"
    }
  }
}



#This is an aws configuration file
provider "aws" {
  region = "us-east-1"
}

#Create an ec2 instance
resource "aws_instance" "prod_instance" {
    ami = "ami-0ed59cbb87dfa8dba"
    instance_type = "t3.micro"
    key_name = "pratice"
    count = 2
    
    tags = {
        Name="Instance"
    }
}

#creating s3 bucket
resource "aws_s3_bucket" "Prod_bucket" {
    bucket = "sridhar-anchualaaaa1-2026"
    tags = {
      Name="sridhar-anchualaaaa-2026"
    }
}