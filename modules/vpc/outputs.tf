output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "environment" {
  value = var.environment
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "public_subnet_az1_id" {
  value = aws_subnet.public_subnet_az1.id
}

output "public_subnet_az2_id" {
  value = aws_subnet.public_subnet_az2.id
}

output "private_app_subnet_az1_id" {
  value = aws_subnet.private_subnet_az1.id
}

output "private_app_subnet_az2_id" {
  value = aws_subnet.private_subnet_az2.id
}

output "private_data_subnet_az1_id" {
  value = aws_subnet.private_data_subnet_az1.id
}

output "private_data_subnet_az2_id" {
  value = aws_subnet.private_data_subnet_az2.id
}

output "availability_zone_1" {
  value = data.aws_availability_zones.available_zones.names[0]
}

output "availability_zone_2" {
  value = data.aws_availability_zones.available_zones.names[1]
}