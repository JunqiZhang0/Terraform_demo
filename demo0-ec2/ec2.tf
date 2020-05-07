provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAXFSDKJZFCPDVWE67"
  secret_key = "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"

}


resource "aws_instance" "ec2" {
  instance_type = "t2.micro"
  ami           = "ami-098f16afa9edf40be"
}
