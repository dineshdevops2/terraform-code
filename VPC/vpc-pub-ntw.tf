#Vpc Creation
resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "test-vpc"
  }
}

#subnet creation
resource "aws_subnet" "pub-sub" {
  vpc_id     = aws_vpc.test.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "pub-sub"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name = "test-igw"
  }
}

#Routing table 
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.test.id
  
  #route the igw to open world
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "pub-rt"
  }
}


#route table association
resource "aws_route_table_association" "sub-ass" {
  subnet_id      = aws_subnet.pub-sub.id
  route_table_id = aws_route_table.pub-rt.id
}