# Use the AWSCLI to run the code to create the bucket first

1. Create the bucket
# # Create the S3 bucket for Terraform state management using AWS CLI or AWS Console before running Terraform. This bucket will be used to store the Terraform state file securely and reliably
aws s3api create-bucket --bucket jupiter-website-ecs-terraform-state --region us-east-1 # replace with your own uniqure bucket name

2. Enable versioning 
# Enable versioning for the S3 bucket backend to ensure that you can recover previous versions of the state file if needed.
aws s3api put-bucket-versioning --bucket jupiter-website-ecs-terraform-state --versioning-configuration Status=Enabled # replace with your own uniqure bucket name 

3. Block public access
aws s3api put-public-access-block --bucket jupiter-website-ecs-terraform-state --public-access-block-configuration BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true # replace with your own uniqure bucket name 

4. Optionally, set up a DynamoDB table
# set up a DynamoDB table for state locking to prevent concurrent modifications to the state file, which can lead to corruption.
aws dynamodb create-table --table-name terraform1-locks --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
