terraform {
  required_providers {
    aws = {
      version = ">=5.41.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-2"

}