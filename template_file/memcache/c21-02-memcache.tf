resource "aws_elasticache_subnet_group" "cache-subnet-group" {
  name       = "cache-subnet-group"
  subnet_ids = [aws_subnet.private-a.id,aws_subnet.private-b.id]
}
resource "aws_elasticache_cluster" "memcache" {
  cluster_id           = "memcache-cluster"
  engine               = "memcached"
  node_type            = var.memcache_type
  num_cache_nodes      = 2
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  subnet_group_name    = aws_elasticache_subnet_group.cache-subnet-group.name
  security_group_ids   = [aws_security_group.memcache-security-group.id]
}
