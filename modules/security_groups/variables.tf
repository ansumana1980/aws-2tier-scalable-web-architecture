variable "project_name" {
  description = "Project name"
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

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed for SSH"
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