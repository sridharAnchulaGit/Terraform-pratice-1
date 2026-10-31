# Create a VPC — 10.81.0.0/16
# Create an Internet Gateway
# Create a Custom Route Table
# Create a public Subnet — 10.81.3.0/24
# Associate the subnet with the route table
# Create a Security Group allowing ports 22, 80, 443 (or all ports/traffic, for this exercise)
# Create a Network Interface with an IP in the subnet from step 4
# Assign an Elastic IP to the network interface from step 7
# Create an EC2 instance using it — and launch an application on it


provider "aws" {
  region = "us-east-1"
}

# Create a VPC — 10.81.0.0/16
resource "aws_vpc" "dev-vpc" {
    cidr_block = "10.81.0.0/16"
    tags = {
      Name="dev-vpc"
    } 
}

# Create an Internet Gateway
resource "aws_internet_gateway" "dev-igw" {
    vpc_id = aws_vpc.dev-vpc.id
    tags = {
        Name="dev-igw"
    }
}

# Create a Custom Route Table
resource "aws_route_table" "dev-rt" {
    vpc_id = aws_vpc.dev-vpc.id
    route {
        cidr_block="0.0.0.0/0"
        gateway_id=aws_internet_gateway.dev-igw.id
    }
  tags = {
    Name="dev-rt"
  }
}

# Create a Custom Route Table
resource "aws_subnet" "dev-subnet" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block = "10.81.3.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name="dev-subnet"
    }
}

# Associate the subnet with the route table
resource "aws_route_table_association" "dev-rta" {
    subnet_id = aws_subnet.dev-subnet.id
    route_table_id = aws_route_table.dev-rt.id
}

# Create a Security Group allowing ports 22, 80, 443 (or all ports/traffic, for this exercise)
resource "aws_security_group" "dev-sg" {
    name = "dev-sg"
    description ="Allow all port 22 80 443 traffic"
    vpc_id = aws_vpc.dev-vpc.id

    ingress  {
        from_port=22
        to_port=22
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }

    ingress  {
        from_port=80
        to_port=80
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }
    
    ingress {
        from_port=443
        to_port=443
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }
    egress  {
        from_port=0
        to_port=0
        protocol="-1"
        cidr_blocks=["0.0.0.0/0"]
    }
    tags={
        Name="dev-sg"
    }
}


# Create a Network Interface with an IP in the subnet from step 4
resource "aws_network_interface" "dev-eni" {
    subnet_id = aws_subnet.dev-subnet.id
    private_ips =  ["10.81.3.33"]
    security_groups = [aws_security_group.dev-sg.id]
    tags = {
      Name="dev-eni"
    }
}

# Assign an Elastic IP to the network interface from step 7
resource "aws_eip" "dev-eip" {
  domain = "vpc"
  network_interface = aws_network_interface.dev-eni.id
  associate_with_private_ip = "10.81.3.33"
  depends_on = [ aws_internet_gateway.dev-igw ]
  tags = {
    Name="dev-eip"
  }
}

resource "time_sleep" "wait_60s" {
    depends_on = [ aws_eip.dev-eip ]
    create_duration = "30s"
  
}

# Create an EC2 instance using it — and launch an application on it
resource "aws_instance" "dev-srv" {
    ami = "ami-0567589d25e06853e"
    instance_type = "t3.micro"
    key_name = "pratice"
    network_interface {
      network_interface_id = aws_network_interface.dev-eni.id
      device_index = 0
    }

    user_data = file("formar.sh")
    tags = {
      Name="dev-srv"
    }
}
#Output the public IP once everything's created
output "instance_public_ip" {
    value = aws_eip.dev-eip.public_ip
}