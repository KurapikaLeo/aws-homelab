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

 # Make a security group for windows 10 and kali cloud EC2
resouce "aws_security_group" "windows_kali_sec_group"{
  name = "windows_kali"
  description = "sec group that allows SSH, RDP, ICMP"
  vpc_id = "${aws_vpc.homelab_vpc.id}"


  ingres{
    from_port = 22
    destination_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingres{
    from_port = 3389
    destination_port = 3389
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingres{
    from_port = -1
    destination_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  engres{
    from_port = 0
    destination_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    windows and kali sec group
  }

}

#security group for linux security tools
resouce "aws_security_group" "linux_sec_tools"{
  name = "linux_sec_tools" 
  description = "set the network ingres and engres rules for the linux tools"
  vpc_id = "${aws_vpc.homelab_vpc.id}"


ingress{
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

}

ingress{
  from_port = -1
  to_port = -1
  protocol = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
  }
ingress{
  from_port = 5900
  to_port = 5920
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
ingress{
  from_port = 3389
  to_port = 3389
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

ingress{
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
ingress{
  from_port = 9997
  to_port = 9997
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

ingress{
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

tags = {
  Name = "linux tools sec group"
}

}

