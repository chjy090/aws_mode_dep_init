#SSH 
resource "aws_security_group" "ssh-security-group" {
  name        = "ssh-security-group"
  description = "ssh-security-group security group"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Postgre from service"
    from_port        = 22
    to_port          = 22
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
    Name = "ssh-security-group"
  }
}
#SERVICE
resource "aws_security_group" "server-security-group" {
  name        = "server-security-group"
  description = "server-security-group security group"
  vpc_id      = var.vpc_id

  ingress {
    description      = "service"
    from_port        = 7777
    to_port          = 7777
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
    Name = "server-security-group"
  }
}
#alb
resource "aws_security_group" "alb-security-group" {
  name        = "alb-security-group"
  description = "alb-security-group security group"
  vpc_id      = var.vpc_id

  ingress {
    description      = "alb"
    from_port        = 80
    to_port          = 80
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
    Name = "alb-security-group"
  }
}
#memcache
resource "aws_security_group" "memcache-security-group" {
  name        = "memcache-security-group"
  description = "memcache security group"
  vpc_id      = var.vpc_id

  ingress {
    description      = "memcache from service"
    from_port        = 11211
    to_port          = 11211
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
    Name = "memcache-security-group"
  }
}
#mysql
resource "aws_security_group" "mysql-security-group" {
  name        = "mysql-security-group"
  description = "mysql-security-group security group"
  vpc_id      = var.vpc_id

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
#postgre
resource "aws_security_group" "postgre-security-group" {
  name        = "postgre-security-group"
  description = "postgre-security-group security group"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Postgre from service"
    from_port        = 5432
    to_port          = 5432
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
    Name = "postgre-security-group"
  }
}
#redis
resource "aws_security_group" "redis-security-group" {
  name        = "redis-security-group"
  description = "redis security group"
  vpc_id      = var.vpc_id

  ingress {
    description      = "redis from service"
    from_port        = 6379
    to_port          = 6379
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
    Name = "redis-security-group"
  }
}
resource "aws_security_group" "efs-security-group" {
  name        = "efs-security-group"
  description = "efs-security-group security group"
  vpc_id      = var.vpc_id

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
    Name = "efs-security-group"
  }
}
#docdb
resource "aws_security_group" "docdb-security-group" {
  name        = "docdb-security-group"
  description = "docdb-security-group security group"
  vpc_id      = var.vpc_id

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

