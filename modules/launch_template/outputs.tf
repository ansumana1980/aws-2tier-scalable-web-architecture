output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.private_web_lt.id
}

output "launch_template_arn" {
  description = "ARN of the launch template"
  value       = aws_launch_template.private_web_lt.arn
}

output "latest_version" {
  description = "Latest version of the launch template"
  value       = aws_launch_template.private_web_lt.latest_version
}