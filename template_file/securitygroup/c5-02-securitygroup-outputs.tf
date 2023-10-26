# AWS EC2 Security Group Terraform Outputs

# Public Bastion Host Security Group Outputs
## public_bastion_sg_group_id
output "ssh-security-group" {
  description = "The ID of the ssh security group"
  value       = aws_security_group.ssh-security-group.id
}

## public_bastion_sg_group_vpc_id
output "server-security-group" {
  description = "The ID of the server security group"
  value       = aws_security_group.server-security-group.id
}

## public_bastion_sg_group_vpc_id
output "alb-security-group" {
  description = "The ID of the server security group"
  value       = aws_security_group.alb-security-group.id
}
