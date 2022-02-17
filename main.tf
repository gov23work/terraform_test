provider "aws" {
  profile  = "terraformWS"
  region   = "eu-central-1"
  default_tags {
    tags = var.my_default_tags
  }
}

variable "my_default_tags" {
  type = map(string)
  description = "Definition for default tags for resources"
  default = {
    automated_through = "Terraform"
    created_by = "Terraform Workshop"
  }
}


resource "aws_instance" "webserver" {
  for_each = toset(["TEST","NOWAY"])
  ami = data.aws_ami.amazon-linux-2.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data = templatefile("user_data.sh", {username ="Kirk"})
  
  tags = merge(local.tags, tomap( {Name = "Tim's Webserver" , cost_center = "6310", stage = "test"}))

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
  value = aws_instance.webserver["TEST"].public_ip
}
output "Second_public_ip" {
  description = "2nd public IP Address"
  value = aws_instance.webserver["NOWAY"].private_ip
}
locals {
  tags = {
    Project = "Paint elephants pink"
    Owner = "<XXX>"
  }
}
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
}
resource "aws_eip" "example"{

}