# store the terraform state in an s3 bucket
terraform {
  backend "s3" {
    bucket         = "2-tier-vpc-architecture-terraform-state"
    key            = "2-tier-vpc-architecture/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-2-tier-vpc-architecture-locks"
    # profile = "terraform-user"
  }


}




