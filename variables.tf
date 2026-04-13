# Environment variables
variable "region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Project name used for naming resources"
  type        = string
}

variable "environment" {
  description = "Environment (dev, test, prod)"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

variable "availability_zone_1" {
  description = "Availability Zone 1"
  type        = string
}

variable "availability_zone_2" {
  description = "Availability Zone 2"
  type        = string
}

# VPC variables
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
}

variable "map_public_ip_on_launch" {
  description = "Assign public IP addresses to resources launched in public subnets"
  type        = bool
}

variable "private_map_public_ip_on_launch" {
  description = "Assign public IP addresses to resources launched in private subnets"
  type        = bool
}

variable "public_subnet_az1_cidr" {
  description = "CIDR block for public subnet in Availability Zone 1"
  type        = string
}

variable "public_subnet_az2_cidr" {
  description = "CIDR block for public subnet in Availability Zone 2"
  type        = string
}

variable "private_subnet_az1_cidr" {
  description = "CIDR block for private subnet in Availability Zone 1"
  type        = string
}

variable "private_subnet_az2_cidr" {
  description = "CIDR block for private subnet in Availability Zone 2"
  type        = string
}