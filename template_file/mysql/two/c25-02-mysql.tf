#mysql
resource "aws_security_group" "rds-mysql-security-group" {
  name        = "rds-mysql-security-group"
  description = "rds-mysql-security-group security group"
  vpc_id      = var.rds_vpc_id

  ingress {
    description      = "mysql from service"
    from_port        = 3306
    to_port          = 3306
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
    Name = "mysql-security-group"
  }
}
#创建postgresql数据库
resource "aws_db_subnet_group" "db-mysql-subnet-group" {
  name       = "db-mysql-subnet-group"
  subnet_ids = [aws_subnet.database-a.id,aws_subnet.database-b.id]
  tags = {
    Name = "My DB subnet group"
  }
}
resource "aws_rds_cluster" "mysql" {
  cluster_identifier      = "aurora-mysql-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.11.2"
  storage_encrypted       = "true"
  skip_final_snapshot     = "true"
  db_subnet_group_name    = aws_db_subnet_group.db-mysql-subnet-group.name
  database_name           = "test"
  master_username         = "root"
  master_password         = "12345678"
  vpc_security_group_ids  = [aws_security_group.rds-mysql-security-group.id]
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  deletion_protection                 = true
  enabled_cloudwatch_logs_exports     = ["audit","error","general","slowquery"]
}
resource "aws_rds_cluster_instance" "cluster_mysql_instances" {
  count              = 2
  identifier         = "aurora-mysql-cluster-demo-${count.index}"
  cluster_identifier = aws_rds_cluster.mysql.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.mysql.engine
  engine_version     = aws_rds_cluster.mysql.engine_version
}
