
---

# 🚀 AWS 2-Tier Architecture with ALB, Auto Scaling & Private Web Tier (Terraform)

## 📌 Overview

This project provisions a **production-style 2-tier AWS architecture** using Terraform, following best practices for:

* High availability (multi-AZ)
* Security (public vs private separation)
* Scalability (Auto Scaling Group)
* Maintainability (modular Terraform design)

The architecture separates:

* **Presentation Layer (Public)**
* **Application Layer (Private)**

---

# 🏗️ Architecture Breakdown

## 🌐 High-Level Flow

```text
User (Internet)
      │
      ▼
Application Load Balancer (Public Subnets)
      │
      ▼
Target Group
      │
      ▼
Auto Scaling Group (Private Subnets)
      │
      ▼
Apache Web Servers (Private EC2)
```

---

## 🧱 Components Explained

### 1. **VPC**

* CIDR: `10.0.0.0/16`
* DNS support & hostnames enabled
* Fully isolated network environment

---

### 2. **Subnets (Multi-AZ)**

| Type    | AZ         | CIDR        | Purpose          |
| ------- | ---------- | ----------- | ---------------- |
| Public  | us-east-1a | 10.0.1.0/24 | ALB + Public EC2 |
| Public  | us-east-1b | 10.0.2.0/24 | ALB + Public EC2 |
| Private | us-east-1a | 10.0.3.0/24 | Web servers      |
| Private | us-east-1b | 10.0.4.0/24 | Web servers      |

---

### 3. **Internet Gateway**

* Enables internet access for public subnets

---

### 4. **NAT Gateway**

* Allows **private instances to access the internet**
* Required for:

  * `yum install httpd`
  * OS updates
  * package downloads

---

### 5. **Route Tables**

#### Public Route Table

```text
0.0.0.0/0 → Internet Gateway
```

#### Private Route Table

```text
0.0.0.0/0 → NAT Gateway
```

---

### 6. **Application Load Balancer (ALB)**

* Deployed in **public subnets**
* Internet-facing
* Distributes traffic across private web servers
* Health checks ensure only healthy instances receive traffic

---

### 7. **Target Group**

* Target type: `instance`
* Port: `80`
* Health check path: `/`
* Ensures traffic is only sent to healthy instances

---

### 8. **Auto Scaling Group (ASG)**

| Setting      | Value |
| ------------ | ----- |
| Min          | 2     |
| Desired      | 2     |
| Max          | 4     |
| Health Check | ELB   |

* Ensures:

  * High availability
  * Fault tolerance
  * Scalability

---

### 9. **Launch Template**

Defines:

* AMI (Amazon Linux 2023 via SSM)
* Instance type
* Security group
* User data script

#### 🧾 User Data (Apache install)

```bash
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Deployed via Terraform</h1>" > /var/www/html/index.html
```

---

### 10. **EC2 Instances**

#### Public EC2 (2 instances)

* Located in public subnets
* Used for:

  * SSH access
  * debugging
  * admin access

#### Private EC2 (Auto Scaling)

* No public IP
* Behind ALB
* Hosts Apache web server

---

## 🔐 Security Architecture

### Security Groups

#### ALB SG

* Inbound: HTTP (80) from `0.0.0.0/0`
* Outbound: All

---

#### Public EC2 SG

* Inbound: SSH (22) from your IP only
* Outbound: All

---

#### Private Web SG

* Inbound: HTTP (80) **ONLY from ALB SG**
* Outbound: All

---

## 🧠 Key Security Principle

> Private instances are **never directly exposed to the internet**

All traffic flows:

```text
Internet → ALB → Private Instances
```

---

# 📁 Project Structure

```text
.
├─.
├── OVERVIEW.md
├── README.md
├── README1.md
├── backend-setup.md
├── backend.tf
├── main.tf
├── modules
│   ├── alb
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── autoscaling
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── launch_template
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── public_ec2
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── security_groups
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vpc
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── outputs.tf
├── providers.tf
├── terraform.tfvars
├── terraform.tfvars.example
├── tplan
└── variables.tf
```

---

# 🔄 Terraform Design Pattern

### Modular Approach

Each component is isolated:

| Module          | Responsibility |
| --------------- | -------------- |
| vpc             | Networking     |
| security_groups | Access control |
| alb             | Load balancing |
| launch_template | EC2 config     |
| autoscaling     | Scaling        |
| public_ec2      | Admin access   |

---

# 🚀 Deployment Guide

## 1. Initialize

```bash
terraform init
```

---

## 2. Validate

```bash
terraform validate
```

---

## 3. Plan

```bash
terraform plan -out=tplan
```

---

## 4. Apply

```bash
terraform apply tplan
```

---

# 📊 Outputs

After deployment:

```bash
terraform output
```

Key outputs:

* `alb_dns_name`
* `public_ec2_public_ips`
* `asg_name`

---

# 🧪 Testing & Validation

## 1. Test Application

```bash
terraform output alb_dns_name
```

Open in browser → Apache page should load

---

## 2. SSH Access

```bash
ssh -i <key.pem> ec2-user@<public_ip>
```

---

## 3. Verify Target Health

AWS Console:

* EC2 → Target Groups → Targets
* Should show **healthy**

---

## 4. Validate Scaling

* Terminate one instance
* ASG should automatically replace it

---

# ⚠️ Troubleshooting

### ❌ ALB returns 503

* Apache not installed
* Target group unhealthy
* Security group misconfigured

---

### ❌ SSH fails

* Wrong key
* IP not whitelisted
* Instance not public

---

### ❌ Web app not loading

* NAT Gateway missing or misconfigured
* Route table issue

---

# 🔥 Real-World Design Benefits

✔ Highly Available (multi-AZ)
✔ Secure (private backend)
✔ Scalable (Auto Scaling)
✔ Maintainable (modular Terraform)
✔ Cloud-native architecture

---

# 🧹 Cleanup

```bash
terraform destroy
```

---

# 👤 Author

**Ansu**
AWS • Terraform • Cloud Architecture

---

# ⭐ Final Notes

This project demonstrates:

* Real-world AWS architecture patterns
* Terraform modular design
* Secure and scalable infrastructure

---

# 🚀 Want to take it further?

Next enhancements you could add:

* HTTPS (ACM + ALB listener 443)
* Route53 domain
* WAF (Web Application Firewall)
* CI/CD pipeline (GitHub Actions)
* CloudWatch monitoring & alarms

---

If you want, I can next:
👉 generate a **professional AWS architecture diagram (PNG with icons)**
👉 or help you **turn this into a GitHub portfolio standout project**
