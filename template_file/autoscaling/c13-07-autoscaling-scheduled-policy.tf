resource "aws_autoscaling_policy" "asg_policy_apply_name_{{apply_name}}" {
  name                      = "asg_policy_${var.apply_name_{{apply_name}}}"
  estimated_instance_warmup = 60
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.asg_apply_name_{{apply_name}}.id
  target_tracking_configuration {
    disable_scale_in = false
    target_value     = 26
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${module.alb.lb_arn_suffix}/${module.alb.target_group_arn_suffixes[{{index_{{apply_name}}}}]}"
    }
  }
}
