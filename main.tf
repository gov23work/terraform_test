provider "aws" {
  profile  = "terraformWS"
  region   = "eu-central-1"
}

resource "aws_instance" "webserver" {
  ami           = "ami-0cd855c8009cb26ef"
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]
  tags = {
    Name = "Tim's Webserver"
    cost_center = "6310"
  }
}
resource "aws_security_group" "web" {
  name_prefix = "web-access"
  description = "Allow access to the server from the web"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "web-access"
  }
}
variable "instance_type" {
  type = string
  description = "Instance type for the web server."
  default = "t2.nano"
}
