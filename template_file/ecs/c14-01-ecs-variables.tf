variable "apply_name_{{apply_name}}" {
  description = "apply_name_{{apply_name}}"
  type = string
  default = "apply_name_{{apply_name}}"
}
variable "{{apply_name}}_image" {
  description = "{{apply_name}}_image"
  type = string
  default = "nginx"
}
variable "{{apply_name}}_execution_role" {
  description = "{{apply_name}}_image"
  type = string
  default = "arn:aws:iam::858786174761:role/ECS-ADMIN"
}
variable "{{apply_name}}_task_role" {
  description = "{{apply_name}}_image"
  type = string
  default = "arn:aws:iam::858786174761:role/ECS-ADMIN"
}
