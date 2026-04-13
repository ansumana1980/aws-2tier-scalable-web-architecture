## 🔥 Full AWS CLI commands

### 1. Create S3 bucket

```bash
aws s3api create-bucket \
  --bucket 2-tier-vpc-architecture-terraform-state \
  --region us-east-1
```

---
### 2. Add tags

```bash
aws s3api put-bucket-tagging \
  --bucket 2-tier-vpc-architecture-terraform-state \
  --tagging 'TagSet=[
    {Key=Name,Value=terraform-state-bucket},
    {Key=Environment,Value=dev},
    {Key=Project,Value=2-tier-vpc},
    {Key=ManagedBy,Value=manual}
  ]'
```

### 3. Enable versioning

```bash
aws s3api put-bucket-versioning \
  --bucket 2-tier-vpc-architecture-terraform-state \
  --versioning-configuration Status=Enabled
```

---

### 4. Enable encryption

```bash
aws s3api put-bucket-encryption \
  --bucket 2-tier-vpc-architecture-terraform-state \
  --server-side-encryption-configuration '{
    "Rules": [{
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "AES256"
      }
    }]
  }'
```

---

### 5. Block public access

```bash
aws s3api put-public-access-block \
  --bucket 2-tier-vpc-architecture-terraform-state \
  --public-access-block-configuration \
  BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true
```

---

### 6. Create DynamoDB table (locking)

```bash
aws dynamodb create-table \
  --table-name terraform-2-tier-vpc-architecture-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```

---


---

## 🚨 Important rule

Once created:

👉 **DO NOT manage that S3 bucket in your VPC Terraform project**



---

## 💬 Interview-ready explanation

If asked:

> “How do you manage Terraform state securely?”

You can say:

> “I provision an S3 bucket with versioning, encryption, and public access blocking using AWS CLI, and configure DynamoDB for state locking. My Terraform projects then use that backend but do not manage it directly.”

