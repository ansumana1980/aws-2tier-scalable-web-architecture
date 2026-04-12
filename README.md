# 🚀 Terraform AWS VPC Infrastructure (Modular Design)

## 📌 Overview

This project provisions a fully functional AWS networking foundation using **Terraform**, following modular and reusable best practices.

It creates a production-style **VPC architecture** with:

* Public and private subnets across multiple Availability Zones
* Internet Gateway and route tables
* Logical separation of application and data tiers

---

## 🏗️ Architecture

The infrastructure is designed using a **modular approach**, where the VPC is defined as a reusable Terraform module.

### Key Components:

* VPC
* Public Subnets (AZ1 & AZ2)
* Private App Subnets (AZ1 & AZ2)
* Private Data Subnets (AZ1 & AZ2)
* Internet Gateway
* Route Tables (Public & Private)

---

## 📂 Project Structure

```
Jupiter-website-ecs/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── backend.tf
├── terraform.tfvars.example
├── README.md
├── .gitignore
│
└── modules/
    └── vpc/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## ⚙️ Prerequisites

* Terraform installed (>= 1.x)
* AWS CLI configured
* AWS account with appropriate permissions

---

## 🔧 Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd Jupiter-website-ecs
```

### 2. Create your variable file

Copy the example file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Update values as needed.

---

### 3. Initialize Terraform

```bash
terraform init
```

---

### 4. Validate configuration

```bash
terraform validate
```

---

### 5. Plan deployment

```bash
terraform plan
```

---

### 6. Apply infrastructure

```bash
terraform apply
```

---

## 🔐 State Management

This project supports remote backend configuration using:

* **S3 (state storage)**
* **DynamoDB (state locking)**

Configured in:

```
backend.tf
```

---

## 💡 Key Design Decisions

* **Modular architecture** for reusability
* **Multi-AZ deployment** for high availability
* Separation of:

  * Public layer (internet-facing)
  * Application layer
  * Data layer
* Parameterized variables for environment flexibility

---

## 🚫 Security Best Practices

The following files are excluded from version control:

* `terraform.tfvars`
* `terraform.tfstate`
* `.terraform/`

---

## 📊 Outputs

After deployment, Terraform provides:

* VPC ID
* Subnet IDs (public, private app, private data)
* Availability Zones
* Internet Gateway ID

---

## 🧠 Future Enhancements

* NAT Gateway for private subnet internet access
* Security Groups and NACLs
* ECS / EC2 deployment
* Load Balancer integration
* CI/CD pipeline (GitHub Actions)

---

## 👤 Author

**Ansu Rogers**
Salesforce | DevOps | Cloud Infrastructure

---

---

# 🧹 2. .gitignore (Copy & Paste)

```gitignore
# Terraform
.terraform/
*.tfstate
*.tfstate.*
crash.log

# Variables (sensitive)
terraform.tfvars
*.auto.tfvars

# Plan files
*.tfplan

# Lock file (optional)
.terraform.lock.hcl

# OS / Editor
.DS_Store
.vscode/
```

---

# 📄 3. terraform.tfvars.example

```hcl
region                       = "us-east-1"
project_name                 = "jupiter-website"
environment                  = "dev"

vpc_cidr_block               = "10.0.0.0/16"

public_subnet_az1_cidr       = "10.0.1.0/24"
public_subnet_az2_cidr       = "10.0.2.0/24"

private_app_subnet_az1_cidr  = "10.0.3.0/24"
private_app_subnet_az2_cidr  = "10.0.4.0/24"

private_data_subnet_az1_cidr = "10.0.5.0/24"
private_data_subnet_az2_cidr = "10.0.6.0/24"
```

---

# 🧠 4. How to Talk About This in Interviews (🔥 THIS IS GOLD)

When they ask:

👉 *“Tell me about a Terraform project you built”*

Say this:

> I built a modular Terraform project to provision a multi-AZ VPC architecture in AWS. I separated the infrastructure into reusable modules and implemented public and private subnet segmentation for application and data layers. I also configured remote state using S3 and DynamoDB for state locking, and followed best practices by excluding sensitive files like tfvars and state from version control. The project is structured to be scalable and ready for future integrations like ECS and load balancing.



