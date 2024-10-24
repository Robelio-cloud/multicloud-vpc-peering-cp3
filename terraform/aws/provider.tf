terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.70"
    }
  }
  backend "s3" {
    bucket         = "tf-s3-cp3-robelio"
    key            = "terraform.tfstate"
    dynamodb_table = "tf-dynamo-cp3-robelio"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}