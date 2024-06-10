

# Make a VPC (virtual private cloud)

resource "aws_vpc" "homelab_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable dns_hostnames = true


  tags = {
    Name = "aws homelab VPC"
  }
}


# Make a public subnet

resource "aws_subnet" "public_subnet"{
  vpc_id = "${aws_vpc.homelab_vpc.id}"
  cidr_block = var.public_subnet_cidr

  tags{
    Name = " Homelab public subnet"
  }
}



# Make a Internet Gateway
resource "aws_internet_gateway" "igw"{
  vpc_id = "${aws_vpc.homelab_vpc.id}"

  tags = {
    Name = "Homelab Internet Gateway"
  }
}

# Make a route table
resource "aws_route_table" "route_table"{
  vpc_id =  "${aws_vpc.homelab_vpc.id}"

}


# 