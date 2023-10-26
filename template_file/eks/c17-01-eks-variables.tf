#EKS ROLE
variable "eks_role" {
  description = "EKS ROLE"
  type = string 
  default = "arn:aws:iam::858786174761:role/eks_role"
}
#EKS NODE ROLE
variable "eks_node_role" {
  description = "EKS NODE ROLE"
  type = string
  default = "arn:aws:iam::858786174761:role/ec2-role"
}
