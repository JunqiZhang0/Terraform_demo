provider "aws" {
  access_key = "AKIAXFSDKJZFCPDVWE67"
  secret_key = "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"
  region     = "us-east-1"
}


resource "aws_instance" "ec2" {
  instance_type   = "t2.micro"
  ami             = "ami-098f16afa9edf40be"
  security_groups = [aws_security_group.sg.name]
}

variable "sg_ports" {
  type        = list(number)
  default     = [8080]
  description = ""
}

resource "aws_security_group" "sg" {
  vpc_id = "vpc-4cc1cb36"
  name   = "sample-sg"
  dynamic "ingress" {       //because the ingress can be several ingree, we don't want to repeat
    for_each = var.sg_ports //this is the iterator, defaults to the block name
    # iterator = port   if this declared, the iterator name will be changed to port
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}


# resource "aws_security_group" "sg" {
#   vpc_id = "vpc-4cc1cb36"
#   name   = "sample-sg"
#   ingress {
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

