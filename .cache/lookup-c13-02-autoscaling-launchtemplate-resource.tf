# Launch Template Resource
resource "aws_launch_template" "apply_name_lookup_launch_template" {
  name = "${var.apply_name_lookup}-launch-template"
  description = "${var.apply_name_lookup} Launch template"
  image_id = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  iam_instance_profile { 
     name = var.iam_instance_profile
  }
  vpc_security_group_ids = [ aws_security_group.server-security-group.id ]
  #key_name = var.instance_keypair
  user_data = filebase64("${path.module}/lookup-app1-install.sh")
  ebs_optimized = false 
  update_default_version = true 
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8 # LT Update Testing - Version 2 of LT              
      delete_on_termination = true
      volume_type = "gp2" # default  is gp2 
    }
   }
  monitoring {
    enabled = true
  }   
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.apply_name_lookup}"
    }
  }  
}
