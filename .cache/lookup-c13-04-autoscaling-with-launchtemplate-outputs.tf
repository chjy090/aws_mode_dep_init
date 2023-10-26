# Launch Template Outputs
## launch_template_id
output "apply_name_lookup_launch_template_id" {
  description = "Launch Template ID"
  value = aws_launch_template.apply_name_lookup_launch_template.id 
}
## launch_template_latest_version
output "apply_name_lookup_launch_template_latest_version" {
  description = "Launch Template Latest Version"
  value = aws_launch_template.apply_name_lookup_launch_template.latest_version 
}

# Autoscaling Outputs
## autoscaling_group_id
output "asg_apply_name_lookup_id" {
  description = "Autoscaling Group ID"
  value = aws_autoscaling_group.asg_apply_name_lookup.id 
}

## autoscaling_group_name
output "autoscaling_group_lookup_name" {
  description = "Autoscaling Group Name"
  value = aws_autoscaling_group.asg_apply_name_lookup.name 
}
## autoscaling_group_lookup_arn
output "autoscaling_group_lookup_arn" {
  description = "Autoscaling Group ARN"
  value = aws_autoscaling_group.asg_apply_name_lookup.arn 
}
