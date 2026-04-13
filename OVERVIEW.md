````markdown
# 2-Tier AWS VPC Architecture with Terraform

This project provisions a **2-tier AWS VPC architecture** using Terraform. It creates a reusable and modular network foundation with **public and private subnets across two Availability Zones**, along with the routing components needed for internet access and secure outbound connectivity.

---

## Project Structure

```bash
2-Tier-VPC-Architecture/
├── .terraform/
├── modules/
│   └── vpc/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── .gitignore
├── .terraform.lock.hcl
├── backend-aws-cli-setup.md
├── backend.tf
├── main.tf
├── outputs.tf
├── OVERVIEW.md
├── providers.tf
├── README.md
├── terraform.tfvars
├── terraform.tfvars.example
├── tplan
└── variables.tf
````

### Structure explanation

* **modules/vpc/**
  Contains the reusable VPC module that creates the VPC, subnets, route tables, Internet Gateway, NAT Gateway, and subnet associations.

* **backend.tf**
  Configures the remote Terraform backend using S3 and DynamoDB.

* **main.tf**
  Calls the VPC module and passes all required variables from the root module.

* **variables.tf**
  Declares input variables used by the root module.

* **terraform.tfvars**
  Stores actual environment-specific values for this deployment.

* **terraform.tfvars.example**
  Template file showing the expected input format for reuse.

* **outputs.tf**
  Exposes important resource IDs and values after deployment.

* **providers.tf**
  Defines the Terraform and AWS provider configuration.

* **OVERVIEW.md / README.md**
  Project documentation and architecture explanation.

---

## What “2-tier” means

This architecture is divided into two layers:

1. **Public tier**
2. **Private tier**

This design is commonly used because it improves:

* security
* simplicity
* scalability
* high availability

---

## 1. The VPC

At the center of the design is the **VPC (Virtual Private Cloud)**.

The VPC is your private network inside AWS. In this project, it:

* has its own CIDR block
* contains all public and private subnets
* includes public and private route tables
* is attached to an Internet Gateway

Think of the VPC as the main network boundary that contains everything else.

---

## 2. Availability Zones

This architecture uses two explicit Availability Zones:

* `availability_zone_1`
* `availability_zone_2`

In your current `terraform.tfvars`, these are set to:

* `us-east-1a`
* `us-east-1b`

Using two Availability Zones improves:

* resilience
* fault tolerance
* high availability

If one Availability Zone has an issue, the other can still continue serving traffic.

---

## 3. Public Tier

You created two public subnets:

* `public_subnet_az1`
* `public_subnet_az2`

These subnets are public because:

* they are associated with the **public route table**
* the public route table sends `0.0.0.0/0` traffic to the **Internet Gateway**
* `map_public_ip_on_launch = true`

This means resources launched in these subnets can receive public IP addresses and communicate with the internet.

### Typical resources in the public tier

Public subnets commonly host:

* Application Load Balancers
* NAT Gateways
* Bastion hosts

This is your **internet-facing layer**.

---

## 4. Internet Gateway

You created an **Internet Gateway** and attached it to the VPC.

The Internet Gateway allows:

* inbound internet traffic to reach public resources
* outbound internet traffic from public resources

Without it, the public subnets would not truly be public.

---

## 5. Public Route Table

You created a route table for the public subnets with a default route:

* destination: `0.0.0.0/0`
* target: Internet Gateway

That route table is associated with both public subnets.

### Result

Any outbound traffic from public subnet resources is routed to the Internet Gateway, making those subnets internet-accessible.

---

## 6. Private Tier

You created two private subnets:

* `private_subnet_az1`
* `private_subnet_az2`

These subnets are private because:

* `private_map_public_ip_on_launch = false`
* they do not use the public route table
* they do not have direct internet-facing access

### Typical resources in the private tier

Private subnets usually host:

* EC2 application servers
* ECS tasks/services
* backend APIs
* internal application components

These workloads are protected from direct internet exposure.

---

## 7. NAT Gateway

You created a **NAT Gateway** in one of the public subnets.

The NAT Gateway allows resources in the private subnets to:

* access the internet for outbound connections
* download updates and packages
* reach external services when needed

At the same time, it does **not** allow the internet to initiate inbound connections directly to private resources.

This is what makes the private tier secure while still being operational.

---

## 8. Private Route Table

You created a private route table with a default route:

* destination: `0.0.0.0/0`
* target: NAT Gateway

This route table is associated with both private subnets.

### Result

Resources in private subnets can send outbound traffic to the internet through the NAT Gateway, but they remain private and are not directly reachable from the internet.

---

## 9. Traffic Flow

### Inbound traffic flow

A typical request path looks like this:

Internet
→ Internet Gateway
→ Public subnet resource
→ Private subnet resource

### Outbound traffic flow

For private resources:

Private subnet
→ Private route table
→ NAT Gateway
→ Internet

This gives you a secure and common cloud networking pattern.

---

## 10. Why this design is strong

### Security

* Internet-facing resources are separated from internal resources
* Private workloads are not directly exposed to the internet

### High availability

* Public and private layers span two Availability Zones

### Scalability

You can extend this design later by adding:

* Application Load Balancer in public subnets
* EC2 or ECS in private subnets
* Auto Scaling Groups
* Security groups for app-specific traffic control

### Reusability

Because this is built as a Terraform module, you can reuse the same architecture across multiple environments by changing only variable values.

---

## 11. Terraform Design

This project uses a **modular Terraform structure**.

### Root module responsibilities

The root module is responsible for:

* provider configuration
* backend configuration
* passing input variables
* calling the VPC module
* exposing outputs

### Child module responsibilities

The child `vpc` module is responsible for creating:

* VPC
* public subnets
* private subnets
* Internet Gateway
* NAT Gateway
* route tables
* route table associations

This design improves:

* code organization
* reusability
* maintainability

---

## 12. Tagging Strategy

This project uses a **common tagging approach** so all resources are consistently labeled.

Example common tags:

```hcl
common_tags = {
  Project      = "ansu-2-tier-vpc"
  Environment  = "dev"
  ManagedBy    = "Terraform"
  Owner        = "Ansu"
  Architecture = "2-tier"
}
```

Each resource also gets a unique `Name` tag, such as:

```hcl
Name = "ansu-2-tier-vpc-dev-private-subnet-az2"
```

This supports:

* governance
* cost tracking
* ownership
* easier AWS console navigation

---

## 13. Example Input Values

Example values used in `terraform.tfvars`:

```hcl
region       = "us-east-1"
project_name = "ansu-2-tier-vpc"
environment  = "dev"

common_tags = {
  Project      = "ansu-2-tier-vpc"
  Environment  = "dev"
  ManagedBy    = "Terraform"
  Owner        = "Ansu"
  Architecture = "2-tier"
}

vpc_cidr_block          = "10.0.0.0/16"
public_subnet_az1_cidr  = "10.0.1.0/24"
public_subnet_az2_cidr  = "10.0.2.0/24"
private_subnet_az1_cidr = "10.0.3.0/24"
private_subnet_az2_cidr = "10.0.4.0/24"

az1 = "us-east-1a"
az2 = "us-east-1b"

enable_dns_support              = true
enable_dns_hostnames            = true
map_public_ip_on_launch         = true
private_map_public_ip_on_launch = false
```

---

## 14. Commands

Initialize Terraform:

```bash
terraform init -reconfigure
```

Format files:

```bash
terraform fmt -recursive
```

Validate configuration:

```bash
terraform validate
```

Preview infrastructure changes:

```bash
terraform plan
```

Apply infrastructure:

```bash
terraform apply
```

Destroy infrastructure:

```bash
terraform destroy
```

---

## 15. Interview Explanation

You can describe this project like this:

> I built a modular 2-tier VPC architecture in AWS using Terraform. The design includes public subnets for internet-facing resources and private subnets for internal application workloads, distributed across two explicitly defined Availability Zones for high availability. I configured an Internet Gateway for public access, a NAT Gateway for secure outbound internet access from private subnets, route tables for traffic flow, and a reusable Terraform module structure with centralized tagging for consistency across environments.

---

## 16. Future Enhancements

This project can be extended by adding:

* Application Load Balancer (ALB)
* EC2 instances in private subnets
* Auto Scaling Group
* Security groups module
* Monitoring and logging


```


