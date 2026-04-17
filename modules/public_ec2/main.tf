resource "aws_instance" "public_ec2" {
  count                       = length(var.public_subnet_ids)
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_ids[count.index]
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-${var.environment}-public-ec2-${count.index + 1}"
      Environment = var.environment
    }
  )
}