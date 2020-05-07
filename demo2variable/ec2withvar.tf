provider "aws" {
  access_key = "AKIAXFSDKJZFCPDVWE67"
  secret_key = "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"
  region     = "us-east-1"
}

# variable "ami" {
#     default = "ami-098f16afa9edf40be"
# }

resource "aws_instance" "ec2" { 
    instance_type = "t2.micro"
    ami = var.ami
}