variable "availability_zone" {
    description = "vpc availability zone"
    type = string
    default = "us-east-1a"
  
}

variable "instance_type" { 
    description = " aws instance type"
    type = string
    default = "t2.micro"
}