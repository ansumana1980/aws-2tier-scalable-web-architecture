output "project_name" {
  value = var.project_name
}

output "environment" {
  value = var.environment
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "public_subnet_az1_id" {
  value = module.vpc.public_subnet_az1_id
}

output "public_subnet_az2_id" {
  value = module.vpc.public_subnet_az2_id
}

output "private_subnet_az1_id" {
  value = module.vpc.private_subnet_az1_id
}

output "private_subnet_az2_id" {
  value = module.vpc.private_subnet_az2_id
}

output "availability_zone_1" {
  value = module.vpc.availability_zone_1
}

output "availability_zone_2" {
  value = module.vpc.availability_zone_2
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "public_ec2_instance_ids" {
  description = "Public EC2 instance IDs"
  value       = module.public_ec2.instance_ids
}

output "public_ec2_public_ips" {
  description = "Public EC2 public IP addresses"
  value       = module.public_ec2.public_ips
}

output "public_ec2_private_ips" {
  description = "Public EC2 private IP addresses"
  value       = module.public_ec2.private_ips
}

output "asg_name" {
  description = "Auto Scaling Group name"
  value       = module.autoscaling.asg_name
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = module.launch_template.launch_template_id
}