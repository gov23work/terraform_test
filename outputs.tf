output "public_ip" {
  description = "Public IP Address"
  value = toset([for webserver in aws_instance.webserver : webserver.public_ip])
}
output "private_ip" {
  description = "Private IP Address"
  value = toset([for webserver in aws_instance.webserver : webserver.private_ip])
}