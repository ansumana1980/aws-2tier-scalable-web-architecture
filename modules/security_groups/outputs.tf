output "alb_sg_id" {
  description = "ALB security group ID"
  value       = aws_security_group.alb_sg.id
}

output "public_ec2_sg_id" {
  description = "Public EC2 security group ID"
  value       = aws_security_group.public_ec2_sg.id
}

output "private_web_sg_id" {
  description = "Private web server security group ID"
  value       = aws_security_group.private_web_sg.id
}