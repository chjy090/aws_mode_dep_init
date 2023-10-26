#可用区
data "aws_availability_zones" "available" {
  state = "available"
}
# VPC ID
variable "vpc_id" {
  description = "VPC ID"
  type = string 
  default = "vpc-047743fc91d1f8248"
}

# IGW ID
variable "igw_id" {
  description = "IGW ID"
  type = string 
  default = "igw-0e2eaf97b658b6070"
}
# VPC ID
variable "rds_vpc_id" {
  description = "RDS VPC ID"
  type = string
  default = "vpc-047743fc91d1f8248"
}

# VPC Public Subnets
variable "vpc_public_subnets" {
  description = "VPC Public Subnets"
  type = list(string)
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}
# VPC Private Subnets
variable "vpc_private_subnets" {
  description = "VPC Private Subnets"
  type = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}
# VPC Database Subnets
variable "vpc_database_subnets" {
  description = "VPC Database Subnets"
  type = list(string)
  default = ["10.0.201.0/24", "10.0.202.0/24"]
}
