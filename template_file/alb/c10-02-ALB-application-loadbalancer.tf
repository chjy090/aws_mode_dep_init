# Terraform AWS Application Load Balancer (ALB)
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.7.0"

  name = "${local.name}-alb"
  load_balancer_type = "application"
  vpc_id = var.vpc_id
  subnets = [
    aws_subnet.public-a.id,
    aws_subnet.public-b.id
  ]
  security_groups = [aws_security_group.alb-security-group.id]
  # Listeners
  # HTTP Listener - HTTP to HTTPS Redirect
    http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      action_type = "forward"
      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]
      conditions = [{
        path_patterns = var.path_a
      }]
    }
  ]
  http_tcp_listener_rules = [
    {
      http_tcp_listener_index = 0
      actions = [
        {
          type               = "forward"
          target_group_index = 1
        }
      ]
      conditions = [{
        path_patterns = var.path_b
      }]
    }
  ]
  # Target Groups
  target_groups = [
    # App1 Target Group - TG Index = 0
    {
      name_prefix          = "app1-"
      backend_protocol     = "HTTP"
      backend_port         = 7777
      target_type          = var.alb_target_type
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/healthcheck"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      # App1 Target Group - Targets
      tags =local.common_tags # Target Group Tags
    },  
    # App2 Target Group - TG Index = 1
    {
      name_prefix          = "app2-"
      backend_protocol     = "HTTP"
      backend_port         = 7777
      target_type          = var.alb_target_type
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      # App2 Target Group - Targets
      tags =local.common_tags # Target Group Tags
    }  
  ]
  tags = local.common_tags # ALB Tags
}
