data "aws_ssm_parameter" "amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  common_tags  = var.common_tags

  vpc_cidr_block                  = var.vpc_cidr_block
  enable_dns_support              = var.enable_dns_support
  enable_dns_hostnames            = var.enable_dns_hostnames
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  private_map_public_ip_on_launch = var.private_map_public_ip_on_launch
  availability_zone_1             = var.availability_zone_1
  availability_zone_2             = var.availability_zone_2
  public_subnet_az1_cidr          = var.public_subnet_az1_cidr
  public_subnet_az2_cidr          = var.public_subnet_az2_cidr
  private_subnet_az1_cidr         = var.private_subnet_az1_cidr
  private_subnet_az2_cidr         = var.private_subnet_az2_cidr
}

module "security_groups" {
  source = "./modules/security_groups"

  project_name     = var.project_name
  environment      = var.environment
  common_tags      = var.common_tags
  vpc_id           = module.vpc.vpc_id
  allowed_ssh_cidr = var.allowed_ssh_cidr
  http_port        = var.http_port
  ssh_port         = var.ssh_port
  alb_ingress_cidr = var.alb_ingress_cidr
  egress_cidr      = var.egress_cidr
}

module "alb" {
  source = "./modules/alb"

  project_name               = var.project_name
  environment                = var.environment
  common_tags                = var.common_tags
  vpc_id                     = module.vpc.vpc_id
  public_subnet_ids          = module.vpc.public_subnet_ids
  alb_sg_id                  = module.security_groups.alb_sg_id
  internal                   = var.internal
  listener_port              = var.listener_port
  listener_protocol          = var.listener_protocol
  target_group_port          = var.target_group_port
  target_group_protocol      = var.target_group_protocol
  target_type                = var.target_type
  health_check_enabled       = var.health_check_enabled
  health_check_path          = var.health_check_path
  health_check_protocol      = var.health_check_protocol
  health_check_matcher       = var.health_check_matcher
  health_check_interval      = var.health_check_interval
  health_check_timeout       = var.health_check_timeout
  healthy_threshold          = var.healthy_threshold
  unhealthy_threshold        = var.unhealthy_threshold
  enable_deletion_protection = var.enable_deletion_protection
  idle_timeout               = var.idle_timeout
}

module "launch_template" {
  source = "./modules/launch_template"

  project_name      = var.project_name
  environment       = var.environment
  common_tags       = var.common_tags
  ami_id            = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type     = var.instance_type_private
  security_group_id = module.security_groups.private_web_sg_id
}

module "autoscaling" {
  source = "./modules/autoscaling"

  project_name       = var.project_name
  environment        = var.environment
  common_tags        = var.common_tags
  private_subnet_ids = module.vpc.private_subnet_ids
  launch_template_id = module.launch_template.launch_template_id
  target_group_arn   = module.alb.target_group_arn
  min_size           = var.min_size
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  health_check_type  = var.health_check_type
  force_delete       = var.force_delete
}

module "public_ec2" {
  source = "./modules/public_ec2"

  project_name                = var.project_name
  environment                 = var.environment
  common_tags                 = var.common_tags
  ami_id                      = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type               = var.instance_type_public
  key_name                    = var.public_key_name
  public_subnet_ids           = module.vpc.public_subnet_ids
  security_group_id           = module.security_groups.public_ec2_sg_id
  associate_public_ip_address = var.associate_public_ip_address
}