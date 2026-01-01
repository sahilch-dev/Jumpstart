resource "aws_vpc" "main" {
  cidr_block                       = "10.0.0.0/16"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  assign_generated_ipv6_cidr_block = true
  tags = {
    Name = "production"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_a"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_b"
  }
}

resource "aws_internet_gateway" "main_igw" {
  tags = {
    Name = "main-igw"
  }
}

resource "aws_internet_gateway_attachment" "main_igw_attachment" {
  vpc_id              = aws_vpc.main.id
  internet_gateway_id = aws_internet_gateway.main_igw.id
}

resource "aws_route_table" "public_route_table_main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-table"
  }
}

resource "aws_route_table_association" "public_subnet_a" {
  route_table_id = aws_route_table.public_route_table_main.id
  subnet_id      = aws_subnet.public_subnet_a.id
}


resource "aws_route_table_association" "public_subnet_b" {
  route_table_id = aws_route_table.public_route_table_main.id
  subnet_id      = aws_subnet.public_subnet_b.id
}

resource "aws_route" "public_route_32" {
  route_table_id         = aws_route_table.public_route_table_main.id
  gateway_id             = aws_internet_gateway.main_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "public_route_64" {
  route_table_id              = aws_route_table.public_route_table_main.id
  gateway_id                  = aws_internet_gateway.main_igw.id
  destination_ipv6_cidr_block = "::/0"

}