resource "aws_elasticache_subnet_group" "redis-subnet-group" {
  name       = "redis-subnet-group"
  subnet_ids = [aws_subnet.private-a.id,aws_subnet.private-b.id]
}
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-cluster"
  engine               = "redis"
  node_type            = var.redis_type
  num_cache_nodes      = 1
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis-subnet-group.name
  security_group_ids   = [aws_security_group.redis-security-group.id]
  log_delivery_configuration {
    destination      = "/log/redis/"
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "slow-log"
  }
}
