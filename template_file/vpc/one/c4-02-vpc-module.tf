resource "aws_subnet" "public-a" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpc_public_subnets[0]
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "public-a"
 }
}
resource "aws_subnet" "public-b" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpc_public_subnets[1]
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "public-b"
 }
}
resource "aws_subnet" "private-a" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpc_private_subnets[0]
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = { 
    Name = "private-a"
 }
}
resource "aws_subnet" "private-b" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpc_private_subnets[1]
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = { 
    Name = "private-b"
 }
}
resource "aws_subnet" "database-a" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpc_database_subnets[1]
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = { 
    Name = "database-a"
 }
}
resource "aws_subnet" "database-b" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpc_database_subnets[0]
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "database-b"
 }
}
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    Name = "public"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.public.id
  depends_on = [aws_subnet.public-a,aws_route_table.public]
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public-b.id
  route_table_id = aws_route_table.public.id
  depends_on = [aws_subnet.public-b,aws_route_table.public]
}
resource "aws_eip" "nat_eip_a" {
  domain           = "vpc"
}
resource "aws_eip" "nat_eip_b" {
  domain           = "vpc"
}
resource "aws_nat_gateway" "nat_a" {
  allocation_id = aws_eip.nat_eip_a.id
  subnet_id     = aws_subnet.public-a.id
  tags = {
    Name = "nat-a"
  }
  depends_on = [aws_eip.nat_eip_a] 
}
resource "aws_nat_gateway" "nat_b" {
  allocation_id = aws_eip.nat_eip_b.id
  subnet_id     = aws_subnet.public-b.id
  tags = {
    Name = "nat-b"
  }
  depends_on = [aws_eip.nat_eip_b]
}
resource "aws_route_table" "rt-private-a" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_a.id
  }
  tags = {
    Name = "rt-private-a"
  }
}
resource "aws_route_table" "rt-private-b" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_b.id
  }
  tags = {
    Name = "rt-private-b"
  }
}
resource "aws_route_table_association" "pr-a" {
  subnet_id      = aws_subnet.private-a.id
  route_table_id = aws_route_table.rt-private-a.id
}
resource "aws_route_table_association" "pr-b" {
  subnet_id      = aws_subnet.private-b.id
  route_table_id = aws_route_table.rt-private-b.id
}
