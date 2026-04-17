output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.private_web_asg.name
}

output "asg_arn" {
  description = "ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.private_web_asg.arn
}

output "asg_id" {
  description = "ID of the Auto Scaling Group"
  value       = aws_autoscaling_group.private_web_asg.id
}