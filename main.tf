module "vpc" {
  source = "./modules/vpc"

  region       = var.region
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