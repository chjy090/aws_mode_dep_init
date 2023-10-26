#创建postgresql数据库
resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.database-a.id,aws_subnet.database-b.id]
  tags = {
    Name = "My DB subnet group"
  }
}
resource "aws_rds_cluster" "mysql" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.11.2"
  storage_encrypted       = "true"
  skip_final_snapshot     = "true"
  db_subnet_group_name    = aws_db_subnet_group.db-subnet-group.name
  database_name           = "test"
  master_username         = "root"
  master_password         = "12345678"
  vpc_security_group_ids  = [aws_security_group.mysql-security-group.id]
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}
resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = aws_rds_cluster.mysql.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.mysql.engine
  engine_version     = aws_rds_cluster.mysql.engine_version
}
