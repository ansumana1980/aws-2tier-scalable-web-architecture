
---

# AWS 2-Tier ALB Auto Scaling Private Web App — Overview

## Objective

This project builds a **highly available 2-tier AWS architecture** using Terraform. The goal is to host a private web application securely behind an **Application Load Balancer (ALB)** with **Auto Scaling**, while separating public-facing and private application resources.

## Architecture Summary

The environment is deployed inside a custom **VPC** spread across **two Availability Zones** for high availability.

### Tier 1: Public Layer

The public layer contains:

* **Public subnets** in two AZs
* An **Internet Gateway**
* A public **Application Load Balancer**
* A **NAT Gateway** for outbound internet access from private resources

The ALB receives incoming web traffic and distributes requests across the application servers.

### Tier 2: Private Application Layer

The private layer contains:

* **Private subnets** in two AZs
* **EC2 instances** running the web application
* An **Auto Scaling Group**
* A **Launch Template**

The EC2 instances do not have direct public access. They are placed in private subnets and only receive traffic through the ALB. This improves security by keeping the application servers hidden from the internet.

## Key Features

* **High availability** across multiple AZs
* **Load balancing** with ALB
* **Elastic scaling** with Auto Scaling Group
* **Improved security** by placing app servers in private subnets
* **Infrastructure as Code** using Terraform
* **Remote state management** with S3 backend and state locking

## Networking Design

* Public subnets route internet traffic through the **Internet Gateway**
* Private subnets route outbound traffic through the **NAT Gateway**
* The ALB is internet-facing
* EC2 instances are private and only accessible from the ALB/security group rules

## Terraform Design

The project uses a **modular structure** to keep the code organized and reusable. Core files typically include:

* `main.tf`
* `variables.tf`
* `outputs.tf`
* `terraform.tfvars`
* reusable modules for networking or compute resources

## Business Value

This architecture reflects a common real-world pattern for hosting secure and scalable web applications in AWS. It demonstrates practical knowledge of:

* VPC design
* subnet segmentation
* ALB configuration
* EC2 launch templates
* Auto Scaling
* Terraform best practices

## Interview Talking Point

> I built a 2-tier AWS architecture with public and private subnets across two Availability Zones. The public tier uses an Application Load Balancer, while the private tier runs EC2 web servers in an Auto Scaling Group. I used Terraform to automate the infrastructure and designed the environment for security, scalability, and high availability.

---


