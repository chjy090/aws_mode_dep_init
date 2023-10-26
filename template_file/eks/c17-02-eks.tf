resource "aws_eks_cluster" "example" {
  name     = "example"
  role_arn = var.eks_role
  version  = "1.25"
  enabled_cluster_log_types = [
    "api",
    "authenticator",
    "controllerManager",
  ]
  vpc_config {
    subnet_ids = [aws_subnet.private-a.id, aws_subnet.private-b.id]
  }
}
resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.example.name
  node_group_name = "example"
  node_role_arn   = var.eks_node_role
  subnet_ids      = [aws_subnet.private-a.id, aws_subnet.private-b.id]
  instance_types  = ["t3.medium"]
  scaling_config {
    desired_size = 1
    max_size     = 20
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }
}
