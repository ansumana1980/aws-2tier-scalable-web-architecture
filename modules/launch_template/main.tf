resource "aws_launch_template" "private_web_lt" {
  name_prefix   = "${var.project_name}-${var.environment}-private-web-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.security_group_id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y httpd
    systemctl enable httpd
    systemctl start httpd
    echo "<h1>Apache Web Server Running on $(hostname -f)</h1>" > /var/www/html/index.html
    EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.common_tags,
      {
        Name        = "${var.project_name}-${var.environment}-private-web"
        Environment = var.environment
      }
    )
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-${var.environment}-launch-template"
      Environment = var.environment
    }
  )
}