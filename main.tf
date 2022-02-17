resource "aws_instance" "webserver" {
  for_each = toset(["TEST","NOWAY"])
  ami = data.aws_ami.amazon-linux-2.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data = templatefile("./templates/user_data.sh", {username ="Kirk"})
  
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

resource "aws_eip" "example"{

}
