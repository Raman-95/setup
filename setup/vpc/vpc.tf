resource "aws_vpc" "main"{
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "${var.project_name}-${var.environment_name}-vpc"
  }
  }
  output "vpc_id" {
  description = "The id of vpc"
  value       = aws_vpc.main.id
  }