output "project_name" {
  value = module.vpc.project_name
}

output "environment" {
  value = module.vpc.environment
}

output "vpc_id" {
  value = module.vpc.vpc_id
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