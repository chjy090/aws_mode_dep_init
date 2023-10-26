# VPC Output Values

# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = var.vpc_id
}

# VPC Private Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = [aws_subnet.private-a.id,aws_subnet.private-b.id]
}

# VPC Public Subnets
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = [aws_subnet.public-a.id,aws_subnet.public-b.id] 
}

# VPC Data Subnets
output "data_subnets" {
  description = "List of IDs of public subnets"
  value       = [aws_subnet.database-a.id,aws_subnet.database-b.id]
}

# VPC AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = [data.aws_availability_zones.available.names[0],data.aws_availability_zones.available.names[1]]
}
