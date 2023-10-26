#创建postgresql数据库
resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.database-a.id,aws_subnet.database-b.id]
  tags = {
    Name = "My DB subnet group"
  }
}
resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-postgresql"
  engine_version          = "13.7"
  storage_encrypted       = "true"
  skip_final_snapshot     = "true"
  db_subnet_group_name    = aws_db_subnet_group.db-subnet-group.name
  database_name           = "postgres"
  master_username         = "postgres"
  master_password         = "12345678"
  vpc_security_group_ids  = [aws_security_group.postgre-security-group.id]
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}
resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = aws_rds_cluster.postgresql.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.postgresql.engine
  engine_version     = aws_rds_cluster.postgresql.engine_version
}
