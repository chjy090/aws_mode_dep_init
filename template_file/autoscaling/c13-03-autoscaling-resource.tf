# Autoscaling Group Resource
resource "aws_autoscaling_group" "asg_apply_name_{{apply_name}}" {
  name_prefix = "asg_${var.apply_name_{{apply_name}}}"
  desired_capacity = 1
  max_size = 10
  min_size = 1
  vpc_zone_identifier = [aws_subnet.private-a.id,aws_subnet.private-b.id]
  target_group_arns = [module.alb.target_group_arns[{{index_{{apply_name}}}}]]
  health_check_type = "ELB"
  health_check_grace_period = 60
  launch_template {
    id = aws_launch_template.apply_name_{{apply_name}}_launch_template.id 
    version = aws_launch_template.apply_name_{{apply_name}}_launch_template.latest_version
  }
  # Instance Refresh
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50            
    }
    triggers = [ "desired_capacity" ] # You can add any argument from ASG here, if those has changes, ASG Instance Refresh will trigger   
  }
  tag {
    key                 = "Owners"
    value               = "Web-Team"
    propagate_at_launch = true
  }
}
