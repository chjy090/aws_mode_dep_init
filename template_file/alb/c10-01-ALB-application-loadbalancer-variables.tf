variable "path_a" {
  description = "server_path"
  type = list(string)
  default = ["/*"]
}
variable "path_b" {
  description = "server_path"
  type = list(string)
  default = ["/app2/*"]
}
variable "alb_target_type" {
  description = "server_path"
  type = string
  default = "ip"
}
