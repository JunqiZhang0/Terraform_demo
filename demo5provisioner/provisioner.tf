provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAXFSDKJZFCPDVWE67"
  secret_key = "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"

}

resource "aws_instance" "ec2" {
  ami             = "ami-098f16afa9edf40be"
  instance_type   = "t2.micro"
  key_name        = "private"
  security_groups = [aws_security_group.sg.name]
  #   provisioner "local-exec"{
  #       command = "echo hello" //this part you can actually run whatever you want
  #   }
  provisioner "remote-exec" {

    inline = [
      #   command 1//it only supports few kinds of provisioners, I guess we can integrate ansible here like a linchpin hook
      # command 2
      "sudo yum -y install httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./private.pem")
      host        = self.public_ip //you can find how to get the corrosponding variable name from the documentation
    }
  }
}

resource "aws_security_group" "sg" {
  vpc_id = "vpc-4cc1cb36"
  name   = "sample-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
