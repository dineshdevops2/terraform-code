resource "aws_security_group" "all_port" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.test.id

  ingress {
    description      = "HTTPS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.test.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.test.ipv6_cidr_block]
  }
  ingress {
    description      = "RDP from VPC"
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.test.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.test.ipv6_cidr_block]
  }
  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.test.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.test.ipv6_cidr_block]
  }  

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "RDP-ssh-https"
  }
}