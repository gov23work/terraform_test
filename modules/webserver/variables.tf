variable "my_default_tags" {
  type = map(string)
  description = "Definition for default tags for resources"
  default = {
    automated_through = "Terraform"
    created_by = "Terraform Workshop"
  }
}
variable "instances" {
  type = set(string)
  default = ["TEST", "NOWAY"]  
}
variable "instance_type" {
  type = string
  description = "Instance type for the web server."
  default = "t2.nano"
}
variable "subnet_id" {
  type = string
}
variable "vpc_id" {
  type = string
}