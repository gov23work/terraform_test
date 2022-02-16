provider "aws" {
  profile  = "terraformWS"
  region   = "eu-central-1"
}

resource "aws_instance" "webserver" {
  ami           = "ami-0cd855c8009cb26ef"
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data = templatefile("user_data.sh", {username ="Kirk"})
  tags = merge(local.tags, tomap( {Name = "Tim's Webserver" , cost_center = "6310"}))

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
output "public_ip" {
  description = "Public IP Address"
  value = aws_instance.webserver.public_ip
}
output "private_ip" {
  description = "Private IP Address"
  value = aws_instance.webserver.private_ip
}
locals {
  tags = {
    Project = "Paint elephants pink"
    Owner = "<XXX>"
  }
}
 
