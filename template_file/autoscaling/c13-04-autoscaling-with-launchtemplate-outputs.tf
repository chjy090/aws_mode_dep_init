# Launch Template Outputs
## launch_template_id
output "apply_name_{{apply_name}}_launch_template_id" {
  description = "Launch Template ID"
  value = aws_launch_template.apply_name_{{apply_name}}_launch_template.id 
}
## launch_template_latest_version
output "apply_name_{{apply_name}}_launch_template_latest_version" {
  description = "Launch Template Latest Version"
  value = aws_launch_template.apply_name_{{apply_name}}_launch_template.latest_version 
}

# Autoscaling Outputs
## autoscaling_group_id
output "asg_apply_name_{{apply_name}}_id" {
  description = "Autoscaling Group ID"
  value = aws_autoscaling_group.asg_apply_name_{{apply_name}}.id 
}

## autoscaling_group_name
output "autoscaling_group_{{apply_name}}_name" {
  description = "Autoscaling Group Name"
  value = aws_autoscaling_group.asg_apply_name_{{apply_name}}.name 
}
## autoscaling_group_{{apply_name}}_arn
output "autoscaling_group_{{apply_name}}_arn" {
  description = "Autoscaling Group ARN"
  value = aws_autoscaling_group.asg_apply_name_{{apply_name}}.arn 
}
