# store the terraform state in an s3 bucket
terraform {
  backend "s3" {
    bucket = "jupiter-website-ecs-terraform-state"
    key    = "jupiter-website-ecs.tfstate"
    region = "us-east-1"
    # profile = "terraform-user"
  }
}

# Prevent accidental deletion of the S3 bucket and DynamoDB table when destroying the infrastructure

resource "aws_s3_bucket" "vpc_state" {
    bucket = "jupiter-website-ecs-terraform-state"
   
        lifecycle {
            prevent_destroy = true
        }

        tags = {
    Name      = "terraform_vpc_state_bucket"
    ManagedBy = "terraform"
  }
}

# Enable versioning for the S3 state bucket
resource "aws_s3_bucket_versioning" "vpc_state" {
    bucket = "jupiter-website-ecs-terraform-state"
    versioning_configuration {
        status = "Enabled"
    }
}

# Enable server-side encryption for the S3 state bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "vpc_state" {
    bucket = "jupiter-website-ecs-terraform-state"
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

# Life cycle rule to transition old versions to Glacier and expire them after a certain period
resource "aws_s3_bucket_lifecycle_configuration" "vpc_state" {
    bucket = "jupiter-website-ecs-terraform-state"
    rule {
            id     = "cleanup-old-versions"
            status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}     

# Block Public Access
resource "aws_s3_bucket_public_access_block" "vpc_state" {
    bucket = "jupiter-website-ecs-terraform-state"
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

# Set up DynamoDB table    
resource "aws_dynamodb_table" "terraform_locks" {
    name         = "terraform-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}
