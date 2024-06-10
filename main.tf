# Make a VPC (virtual private cloud)
resource "aws_vpc" "homelab_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "aws homelab VPC"
  }
}

# Make a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.homelab_vpc.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "Homelab public subnet"
  }
}

# Add additional configuration here, for example, an internet gateway, route tables, etc.

# Example of an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.homelab_vpc.id

  tags = {
    Name = "Homelab IGW"
  }
}

# Example of a Route Table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.homelab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Homelab Route Table"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table.id
}

