resource "aws_security_group" "rds-docdb-security-group" {
  name        = "rds-docdb-security-group"
  description = "rds-docdb-security-group security group"
  vpc_id      = var.rds_vpc_id

  ingress {
    description      = "docdb from service"
    from_port        = 27017
    to_port          = 27017
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
    Name = "docdb-security-group"
  }
}
#创建postgresql数据库
resource "aws_docdb_subnet_group" "db-subnet-group" {
  name       = "docdb-subnet-group"
  subnet_ids = [aws_subnet.database-a.id,aws_subnet.database-b.id]
  tags = {
    Name = "My DB subnet group"
  }
}
resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "docdb-cluster-demo"
  engine                  = "docdb"
  storage_encrypted       = "true"
  skip_final_snapshot     = "true"
  deletion_protection     = true
  db_subnet_group_name    = aws_docdb_subnet_group.db-subnet-group.name
  master_username         = "docdb"
  master_password         = "12345678"
  vpc_security_group_ids  = [aws_security_group.rds-docdb-security-group.id]
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  enabled_cloudwatch_logs_exports = ["audit","profiler"]
}
resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "docdb-cluster-demo-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = "db.t3.medium"
}

