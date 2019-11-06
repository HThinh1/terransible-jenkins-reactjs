resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.PROJECT_NAME}_vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.PROJECT_NAME}_igw"
  }
}

# Public Route table

resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }

  tags = {
    Name = "${var.PROJECT_NAME}_public_rt"
  }
}

# Private Route table

resource "aws_default_route_table" "private_rt" {
  default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"

  tags = {
    Name = "${var.PROJECT_NAME}_private"
  }
}

# Public Subnets

resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.cidrs["public"]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags = {
    Name = "${var.PROJECT_NAME}_public"
  }
}
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.cidrs["public1"]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"

  tags = {
    Name = "${var.PROJECT_NAME}_public1"
  }
}

# Private Subnets

resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.cidrs["private"]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags = {
    Name = "${var.PROJECT_NAME}_private"
  }
}
resource "aws_subnet" "private_subnet1" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.cidrs["private1"]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[2]}"

  tags = {
    Name = "${var.PROJECT_NAME}_private1"
  }
}

# Subnetes association

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}
resource "aws_route_table_association" "public1_assoc" {
  subnet_id      = "${aws_subnet.public_subnet1.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_default_route_table.private_rt.id}"
}
resource "aws_route_table_association" "private1_assoc" {
  subnet_id      = "${aws_subnet.private_subnet1.id}"
  route_table_id = "${aws_default_route_table.private_rt.id}"
}
