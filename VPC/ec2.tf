
#public instance creation
resource "aws_instance" "pub-vm" {
  ami                    = data.aws_ami.linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.pub-sub.id
  vpc_security_group_ids = [aws_security_group.all_port.id]
  key_name               = "vm-key"

  tags = {
    Name = "pubvm"
  }
}

#private instance creation
resource "aws_instance" "pvt-vm" {
  ami                    = data.aws_ami.linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.pvt-sub.id
  vpc_security_group_ids = [aws_security_group.all_port.id]
  key_name               = "vm-key"

  tags = {
    Name = "pubvm"
  }
}

#key file creation
resource "aws_key_pair" "deployer" {
  key_name   = "vm-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 ddini882@gmail.com"
}

#datasource to fetch the aws instance
data "aws_ami" "linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
    }
 
  filter {
    name   = "root-device-type"
    values = ["ebs"]
    }
}
