provider "aws" {
  profile  = "terraformWS"
  region   = "eu-central-1"
  default_tags {
    tags = var.my_default_tags
  }
}