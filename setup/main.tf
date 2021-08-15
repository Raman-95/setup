 module "vpc" {
       source = ".//vpc/"

       cidr_block = var.cidr_block
       environment_name = var.environment_name
       project_name = var.project_name

    }