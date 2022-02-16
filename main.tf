provider "aws" {
  profile  = "terraformWS"
  region   = "eu-central-1"
}

resource "aws_instance" "webserver" {
  ami           = "ami-0cd855c8009cb26ef"
  instance_type = "t2.nano"
}