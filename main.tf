module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "my-vpc"
  cidr = "10.0.0.0/16"
  azs = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
}
module "test-webserver" {
  source = "./modules/webserver"

  subnet_id = module.vpc.public_subnets[0]
  vpc_id = module.vpc.vpc_id

  instance_type = var.instance_type
}
terraform {
  backend "s3" {
    profile = "terraformWS"
    bucket = "qwiklabs-tfstate-f8fa09d0-8fc8-11ec-8884-0a3035716952"
    dynamodb_table = "qwiklabs-tfstate-lock"
    key = "terraform.tfstate"
    region = "eu-central-1"
  }
}
resource "aws_s3_bucket" "name" {
  bucket_prefix = terraform.workspace
}