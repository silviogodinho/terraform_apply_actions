terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.8.0"
    }
    template = {
      source  = "hashicorp/template"
      version = ">= 2.2.0"
    }
  }
  backend "s3" {
    
    bucket = "tfstate-segurity-iac"

    key = "dev/terraform-state/terraform.tfstate"

    region = "us-east-1"


  }
}

provider "aws" {
  region                  = "us-east-1"
  # shared_credentials_file = "~/.aws/credentials"
}




