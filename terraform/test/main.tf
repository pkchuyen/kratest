terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.46.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "iam_test" {
  source = "../module"

  name           = "kratest-ci"
  aws_account_id = "009384221123" # just for example

  tags = {
    name = "kratest-ci"
    env  = "test"
  }
}