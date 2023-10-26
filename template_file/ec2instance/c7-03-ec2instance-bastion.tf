# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"
  # insert the 10 required variables here
  name                   = "${var.environment}-BastionHost"
  #instance_count         = 5
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  #user_data = file("${path.module}/apache-install.sh")
  #monitoring             = true
  subnet_id              = aws_subnet.public-a.id
  vpc_security_group_ids = [aws_security_group.ssh-security-group.id,aws_security_group.server-security-group.id]
  tags = local.common_tags
}
