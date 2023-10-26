resource "aws_security_group" "rds-efs-security-group" {
  name        = "rds-efs-security-group"
  description = "rds-efs-security-group security group"
  vpc_id      = var.rds_vpc_id

  ingress {
    description      = "service"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "rds-efs-security-group"
  }
}
resource "aws_efs_file_system" "efs1" {
  encrypted = "true"
  tags = {
    Name = "MyProduct"
  }
}
resource "aws_efs_mount_target" "alpha1" {
  file_system_id  = aws_efs_file_system.efs1.id
  subnet_id       = aws_subnet.database-a.id
  security_groups = [aws_security_group.rds-efs-security-group.id]
}
resource "aws_efs_mount_target" "alpha2" {
  file_system_id  = aws_efs_file_system.efs1.id
  subnet_id       = aws_subnet.database-b.id
  security_groups = [aws_security_group.rds-efs-security-group.id]
}
