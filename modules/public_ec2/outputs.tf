output "instance_ids" {
  description = "IDs of the public EC2 instances"
  value       = aws_instance.public_ec2[*].id
}

output "public_ips" {
  description = "Public IP addresses of the public EC2 instances"
  value       = aws_instance.public_ec2[*].public_ip
}

output "private_ips" {
  description = "Private IP addresses of the public EC2 instances"
  value       = aws_instance.public_ec2[*].private_ip
}