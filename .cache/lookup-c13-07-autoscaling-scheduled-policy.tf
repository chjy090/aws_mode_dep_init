resource "aws_autoscaling_policy" "asg_policy_apply_name_lookup" {
  name                      = "asg_policy_${var.apply_name_lookup}"
  estimated_instance_warmup = 60
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.asg_apply_name_lookup.id
  target_tracking_configuration {
    disable_scale_in = false
    target_value     = 26
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${module.alb.lb_arn_suffix}/${module.alb.target_group_arn_suffixes[1]}"
    }
  }
}
