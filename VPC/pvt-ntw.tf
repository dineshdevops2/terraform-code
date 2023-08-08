resource "aws_subnet" "pvt-sub" {
    vpc_id     = aws_vpc.test.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "pvt-sub"
  }
}

resource "aws_route_table" "pvt-rt" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  } 
}

resource "aws_eip" "my-ip" {
  vpc      = true
  tags = {
    Name = "my-eip"
  }
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.my-ip.id
  subnet_id     = aws_subnet.pub-sub.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table_association" "sub-ass-pvt" {
  subnet_id      = aws_subnet.pvt-sub.id
  route_table_id = aws_route_table.pvt-rt.id
}

