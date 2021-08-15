resource "aws_db_subnet_group" "subnet_group" {
   name        = "${var.project_name}-${var.environment_name}-db-subnetgroup"
   subnet_ids  = [aws_subnet.db_subnet1.id,aws_subnet.db_subnet2.id]
   description = "subnet group for rds"
   tags = {
      Name = "${var.project_name}-${var.environment_name}-db-subnetgroup"
       }
}