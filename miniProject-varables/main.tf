
provider "aws" {
  region = "us-east-1"
}

# 1. Create VPC
resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "dev-vpc"
  }
}

# 2. Create Internet Gateway
resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = "dev-igw"
  }
}

# 3. Create Route Table
resource "aws_route_table" "dev-rt" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-igw.id
  }

  tags = {
    Name = "dev-rt"
  }
}

# 4. Create Public Subnet
resource "aws_subnet" "dev-subnet" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "dev-subnet"
  }
}

# 5. Associate Route Table with Subnet
resource "aws_route_table_association" "dev-rta" {
  subnet_id      = aws_subnet.dev-subnet.id
  route_table_id = aws_route_table.dev-rt.id
}

# 6. Create Security Group
resource "aws_security_group" "dev-sg" {
  name        = "dev-sg"
  description = "Allow SSH, HTTP and HTTPS traffic"
  vpc_id      = aws_vpc.dev-vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
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
    Name = "dev-sg"
  }
}

# 7. Create Network Interface
resource "aws_network_interface" "dev-eni" {
  subnet_id       = aws_subnet.dev-subnet.id
  private_ips     = var.eni_pvt_ip
  security_groups = [aws_security_group.dev-sg.id]

  tags = {
    Name = "dev-eni"
  }
}

# 8. Allocate Elastic IP
resource "aws_eip" "dev-eip" {
  domain = "vpc"

  tags = {
    Name = "dev-eip"
  }
}

# 9. Create EC2 Instance
resource "aws_instance" "dev-srv" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_pair

  network_interface {
    network_interface_id = aws_network_interface.dev-eni.id
    device_index         = 0
  }

  user_data = file("formar.sh")

  tags = {
    Name = var.srv_name
  }
}

# 10. Associate EIP after EC2 creation
resource "aws_eip_association" "dev-eip-association" {
  allocation_id        = aws_eip.dev-eip.id
  network_interface_id = aws_network_interface.dev-eni.id
  private_ip_address   = var.eni_pvt_ip[0]

  depends_on = [aws_instance.dev-srv]
}

# Output the public IP
output "instance_public_ip" {
  value = aws_eip.dev-eip.public_ip
}
