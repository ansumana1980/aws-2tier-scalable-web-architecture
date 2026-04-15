
---

````md
# 🔐 Terraform Backend Setup (S3 + DynamoDB)

This guide walks through setting up a **remote backend** for Terraform using:

- Amazon S3 (state storage)
- DynamoDB (state locking)

> ⚠️ Complete these steps **before running `terraform init`**

---

## 🧾 Overview

This setup provides:

- ✅ Centralized Terraform state (S3)
- ✅ Version history (S3 versioning)
- ✅ Secure storage (no public access)
- ✅ Safe concurrent execution (DynamoDB locking)

---

## 🪣 Step 1: Create S3 Bucket

```bash
aws s3api create-bucket \
  --bucket <YOUR_BUCKET_NAME> \
  --region us-east-1
````

---

## 🔄 Step 2: Enable Versioning

```bash
aws s3api put-bucket-versioning \
  --bucket <YOUR_BUCKET_NAME> \
  --versioning-configuration Status=Enabled
```

---

## 🔒 Step 3: Block Public Access

```bash
aws s3api put-public-access-block \
  --bucket <YOUR_BUCKET_NAME> \
  --public-access-block-configuration \
  BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true
```

---

## 🧱 Step 4: Create DynamoDB Table

```bash
aws dynamodb create-table \
  --table-name <TABLE_NAME> \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```

---

## ⚙️ Step 5: Configure Terraform Backend

Update your `backend.tf` file:

```hcl
terraform {
  backend "s3" {
    bucket         = "<YOUR_BUCKET_NAME>"
    key            = "s3-static-website/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "<TABLE_NAME>"
    encrypt        = true
  }
}
```

---

## ▶️ Step 6: Initialize Terraform

```bash
terraform init
```

---

## 💡 Example (Optional)

```hcl
bucket         = "ansu-s3-static-website-state"
dynamodb_table = "ansu-s3-static-website-locks"
```

---

## ⚠️ Notes

* Bucket names must be globally unique
* Never expose Terraform state publicly
* Always run `terraform init` after backend changes

---

## 💬 Interview Talking Point

> “I implemented a reusable Terraform backend setup using parameterized S3 and DynamoDB resources to support different environments securely.”









