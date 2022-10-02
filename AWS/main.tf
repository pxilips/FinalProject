# Configure the AWS Provider
provider "aws" {
	access_key = var.access
	secret_key = var.secret
    region = var.region
}

# Create VPC
resource "aws_vpc" "my-VPC" {
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "my-VPC"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "my-INTERNETGATEWAY" {
  vpc_id = aws_vpc.my-VPC.id

  tags   = {
    Name = "my-INTERNETGATEWAY"
  }
}

# Create Subnet
## Create Subnet Public
resource "aws_subnet" "public-SUBNET" {
  vpc_id            = aws_vpc.my-VPC.id
  cidr_block        = "10.0.1.0/25"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-SUBNET"
  }
}

# Create Instance
## Create Ubuntu
resource "aws_instance" "Management" {
  ami           = "ami-06148e0e81e5187c8"
  instance_type = var.instance_type
  subnet_id   = aws_subnet.public-SUBNET.id
  key_name = "aws-philipsn"
  security_groups = [aws_security_group.Management-SG.id]
  user_data = file("script.sh")
    tags = {
    Name = "Management"
    Owner = "Andrei Rudnikov"
    Project = "Final Project"
    }
  }

# Create Security Group
resource "aws_security_group" "Management-SG" {
  name        = "Management-SG"
  vpc_id = aws_vpc.my-VPC.id
  
ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
ingress {
    description      = "RDP"
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

ingress {
    description      = "Jenkins"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

ingress {
    description      = "Grafana"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# Create Route Table
## Create Route Table Public
resource "aws_route_table" "my-VPC-RT-public" {
  vpc_id = aws_vpc.my-VPC.id
  
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-INTERNETGATEWAY.id
  }
  
    tags = {
    Name = "my-VPC-RT-public"
  }
}

resource "aws_route_table_association" "my-VPC-RT-public" {
  subnet_id   = aws_subnet.public-SUBNET.id
  route_table_id = aws_route_table.my-VPC-RT-public.id
}
