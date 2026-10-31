provider "aws" {
  region = "us-east-1"
  alias = "nv"
}

provider "aws" {
  region = "ap-south-2"
  alias = "hyd"
}

#creating an ec2 instance
resource "aws_instance" "Prod_srv2" {
    ami = "ami-0567589d25e06853e"
    instance_type = "t3.micro"
    count = 1
    key_name = "pratice"
    provider = aws.nv
    tags = {
      Name="Prod_srv"
    }
    user_data = file("formar.sh")
}

resource "aws_instance" "hyd-serv" {
  ami = "ami-04f617474d20eae29"
  instance_type = "t3.micro"
  key_name = "hydrabadkey"
  provider = aws.hyd
  tags = {
    Name = "hyd-serv"
  }
  user_data = file("formar.sh")
}