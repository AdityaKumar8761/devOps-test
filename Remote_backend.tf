terraform {
  backend "s3" {
    bucket = "aditya-devoptest-1905"
    key = "terraform.tfstate"
    region = "sa-east-1"
  }
}