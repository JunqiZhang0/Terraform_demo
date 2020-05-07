provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAXFSDKJZFCPDVWE67"
  secret_key = "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"
}

variable "names" {
  type    = list(string)
  default = ["test1", "test2", "test3"]
}

resource "aws_iam_user" "demo_test_user" { 
  name = "demo-user-.${count.index}"
  count = 3
}