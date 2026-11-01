provider "aws" {
    region = "us-east-1"
}


resource "aws_instance" "prod" {
  # (resource arguments)
    ami = "ami-0c230065b91270bc6"
    instance_type = "t3.micro"
    tags = {
      Name="prodServer"
    }
  
}
resource "aws_s3_bucket" "prod_bucket" {
  # (resource arguments)
  bucket = "oct-2026-sridhar"
  tags = {
    Name ="dev"
  }
}
