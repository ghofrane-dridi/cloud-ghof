terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.2.0"
    }
  }
}

# Provider principal (Europe / S3 / Route53)
provider "aws" {
  region = "eu-north-1"
}

# Provider alias pour ACM (OBLIGATOIRE en us-east-1)
provider "aws" {
  alias  = "east"
  region = "us-east-1"
}
