provider "aws" {
  access_key = "AKIAXFSDKJZFCPDVWE67"
  secret_key = "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"
  region     = "us-east-1"
}

data "aws_ami" "ami" {
  owners      = ["309956199498"]
  most_recent = true
  filter {
    name   = "name"
    values = ["RHEL-8.2.0_HVM*"]
  }
}

resource "aws_instance" "ec2" {
  instance_type = "t2.micro"
    ami = data.aws_ami.ami.id
}
