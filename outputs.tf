output "public_ip" {
  description = "Public IP Address"
  value = module.test-webserver.public_ip
}
output "private_ip" {
  description = "Private IP Address"
  value = module.test-webserver.private_ip
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value = module.vpc.public_subnets
}

output "vpc_id" {
  description = "VPC ID"
  value = module.vpc.vpc_id
}