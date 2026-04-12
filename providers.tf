# Set terrfarm required version and provider configurations
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.38" # Specify the AWS provider version you want to use
    }
  }
}

# Configure the AWS provider with your region
provider "aws" {
  region = var.region
  # profile   = "terraform-user"

}
