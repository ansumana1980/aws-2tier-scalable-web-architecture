terraform {
  backend "s3" {
    bucket         = "aws-2tier-alb-autoscaling-webapp-state" # replace with unique bucket name
    key            = "aws-2tier-alb-autoscaling-webapp/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "aws-2tier-alb-autoscaling-webapp-locks"
    encrypt        = true
  }
}