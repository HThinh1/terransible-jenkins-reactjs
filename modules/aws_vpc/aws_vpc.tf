resource "aws_vpc" "devops_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "devops_vpc"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "devops_internet_gateway" {
  vpc_id = "${aws_vpc.devops_vpc.id}"

  tags {
    Name = "devops_igw"
  }
}

# Public Route table

resource "aws_route_table" "devops_public_rt" {
  vpc_id = "${aws_vpc.devops_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.devops_internet_gateway.id}"
  }

  tags {
    Name = "devops_public_rt"
  }
}

# Private Route table

resource "aws_default_route_table" "devops_private_rt" {
  default_route_table_id = "${aws_vpc.devops_vpc.default_route_table_id}"

  tags {
    Name = "devops_private"
  }
}

# Public Subnets

resource "aws_subnet" "devops_public_subnet" {
  vpc_id                  = "${aws_vpc.devops_vpc.id}"
  cidr_block              = "${var.cidrs["public"]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "devops_public"
  }
}

# Private Subnets

resource "aws_subnet" "devops_private_subnet" {
  vpc_id                  = "${aws_vpc.devops_vpc.id}"
  cidr_block              = "${var.cidrs["private"]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "devops_private"
  }
}

# Subnetes association

resource "aws_route_table_association" "terra_public_assoc" {
  subnet_id      = "${aws_subnet.devops_public_subnet.id}"
  route_table_id = "${aws_route_table.devops_public_rt.id}"
}

resource "aws_route_table_association" "terra_private_assoc" {
  subnet_id      = "${aws_subnet.devops_private_subnet.id}"
  route_table_id = "${aws_default_route_table.devops_private_rt.id}"
}