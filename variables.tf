#################################################################
# 🌍 Environment / Global
#################################################################

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

#################################################################
# 🌐 VPC
#################################################################

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zone_1" {
  description = "Availability Zone 1"
  type        = string
}

variable "availability_zone_2" {
  description = "Availability Zone 2"
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
  description = "CIDR block for public subnet AZ1"
  type        = string
}

variable "public_subnet_az2_cidr" {
  description = "CIDR block for public subnet AZ2"
  type        = string
}

variable "private_subnet_az1_cidr" {
  description = "CIDR block for private subnet AZ1"
  type        = string
}

variable "private_subnet_az2_cidr" {
  description = "CIDR block for private subnet AZ2"
  type        = string
}

#################################################################
# 🔐 Security
#################################################################

variable "allowed_ssh_cidr" {
  description = "CIDR allowed for SSH access"
  type        = string
}

variable "http_port" {
  description = "HTTP port"
  type        = number
  default     = 80
}

variable "ssh_port" {
  description = "SSH port"
  type        = number
  default     = 22
}

variable "alb_ingress_cidr" {
  description = "CIDR allowed to access ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_cidr" {
  description = "CIDR for outbound traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

#################################################################
# 🚀 EC2 / Launch Template
#################################################################

variable "instance_type_public" {
  description = "Instance type for public EC2"
  type        = string
}

variable "instance_type_private" {
  description = "Instance type for private web servers"
  type        = string
}

variable "public_key_name" {
  description = "Existing EC2 key pair name"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Associate public IP to EC2"
  type        = bool
  default     = true
}

#################################################################
# 🌐 ALB
#################################################################

variable "internal" {
  description = "Whether ALB is internal"
  type        = bool
  default     = false
}

variable "listener_port" {
  description = "ALB listener port"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "ALB listener protocol"
  type        = string
  default     = "HTTP"
}

variable "target_group_port" {
  description = "Target group port"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Target group protocol"
  type        = string
  default     = "HTTP"
}

variable "target_type" {
  description = "Target type for ALB"
  type        = string
  default     = "instance"
}

variable "health_check_enabled" {
  description = "Enable health checks"
  type        = bool
  default     = true
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/"
}

variable "health_check_protocol" {
  description = "Health check protocol"
  type        = string
  default     = "HTTP"
}

variable "health_check_matcher" {
  description = "Expected HTTP code"
  type        = string
  default     = "200"
}

variable "health_check_interval" {
  description = "Health check interval"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Health check timeout"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Healthy threshold"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Unhealthy threshold"
  type        = number
  default     = 2
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for ALB"
  type        = bool
  default     = false
}

variable "idle_timeout" {
  description = "Idle timeout for ALB"
  type        = number
  default     = 60
}

#################################################################
# 📈 Auto Scaling
#################################################################

variable "min_size" {
  description = "Minimum instances in ASG"
  type        = number
}

variable "desired_capacity" {
  description = "Desired instances in ASG"
  type        = number
}

variable "max_size" {
  description = "Maximum instances in ASG"
  type        = number
}

variable "health_check_type" {
  description = "ASG health check type"
  type        = string
  default     = "ELB"
}

variable "force_delete" {
  description = "Force delete ASG"
  type        = bool
  default     = false
}