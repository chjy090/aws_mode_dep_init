resource "aws_efs_file_system" "efs1" {
  encrypted = "true"
  tags = {
    Name = "MyProduct"
  }
}
resource "aws_efs_mount_target" "alpha1" {
  file_system_id  = aws_efs_file_system.efs1.id
  subnet_id       = aws_subnet.database-a.id
  security_groups = [aws_security_group.efs-security-group.id]
}
resource "aws_efs_mount_target" "alpha2" {
  file_system_id  = aws_efs_file_system.efs1.id
  subnet_id       = aws_subnet.database-b.id
  security_groups = [aws_security_group.efs-security-group.id]
}
