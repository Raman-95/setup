variable "region" {}
    variable "environment_name" {}
    variable "project_name" {}
    variable "cidr_block" {}
    variable "group_name" {
       type = string
    }
  #  variable "iam_user" {}
   # variable "billing_limit" {
    #   description = "Budget alarm limit"
     #  type        = number
    #}
#    variable "email_address" {}
 #   variable "db_security_port" {}

        variable "db_instance_username" {
           type  = string
           sensitive = true
        }
        variable "db_instance_password" {
           type  = string
           sensitive = true
        } 