
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Security Group
resource "aws_security_group" "provisioner_sg" {
  name        = "provisioner-sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "provisioner-sg"
  }
}

# Create EC2 Instance
resource "aws_instance" "Provisinores_server" {
  ami                    = "ami-0567589d25e06853e"
  instance_type           = "t3.micro"
  key_name                = "pratice"
  vpc_security_group_ids  = [aws_security_group.provisioner_sg.id]

  # SSH Connection
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/Anchula Sridhar/Desktop/keyPairs_devops/pratice.pem")
    host        = self.public_ip
    timeout     = "5m"
  }

  # Copy local HTML file to EC2
  provisioner "file" {
    source      = "${path.module}/index.html"
    destination = "/tmp/index.html"
  }

  # Install Apache and deploy website
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo systemctl enable --now httpd",
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo systemctl restart httpd"
    ]
  }

  # Local-exec provisioner
  provisioner "local-exec" {
    command = "echo 'This is Farmer Connect server IP: ${self.public_ip}' > formar-server-ip.txt"
  }

  tags = {
    Name = "Farmer-Connect-Server"
  }
}

# Output Public IP
output "instance_public_ip" {
  value = aws_instance.Provisinores_server.public_ip
}
