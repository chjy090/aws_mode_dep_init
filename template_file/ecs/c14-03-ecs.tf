resource "aws_ecs_cluster" "ecs_cluster_{{apply_name}}" {
  name = "ecs_cluster_{{apply_name}}"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
resource "aws_ecs_task_definition" "task_def_{{apply_name}}" {
  family = "task_def_{{apply_name}}"
  container_definitions = jsonencode([
    {
        "name": var.apply_name_{{apply_name}},
        "image": var.{{apply_name}}_image,
        "portMappings": [
            {
                "name": "app-{{apply_name}}-7777-tcp",
                "containerPort": 7777,
                "hostPort": 7777,
                "protocol": "tcp",
                "appProtocol": "http"
            }
        ],
        "essential": true,
        "environment": [],
        "environmentFiles": [],
        "mountPoints": [],
        "volumesFrom": [],
        "ulimits": [],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-create-group": "true",
                "awslogs-group": "/ecs/{{apply_name}}",
                "awslogs-region": "us-east-1",
                "awslogs-stream-prefix": "ecs"
            },
            "secretOptions": []
        }
    }
])
  execution_role_arn = var.{{apply_name}}_execution_role
  memory = 1024
  cpu = 512
  network_mode = "awsvpc"
  task_role_arn = var.{{apply_name}}_task_role
}
resource "aws_ecs_service" "server_{{apply_name}}" {
  name            = "nginx"
  cluster         = aws_ecs_cluster.ecs_cluster_{{apply_name}}.id
  task_definition = aws_ecs_task_definition.task_def_{{apply_name}}.arn
  desired_count   = 3
  #iam_role        = aws_iam_role.foo.arn
  #depends_on      = [aws_iam_role_policy.foo]


  load_balancer {
    target_group_arn = module.alb.target_group_arns[{{index_{{apply_name}}}}]
    container_name   = var.apply_name_{{apply_name}}
    container_port   = 7777
  }
  launch_type = "FARGATE"
  network_configuration {
    subnets = [aws_subnet.private-a.id,aws_subnet.private-b.id]
    security_groups = [aws_security_group.server-security-group.id]
  }
}
resource "aws_appautoscaling_target" "ecs_target_{{apply_name}}" {
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster_{{apply_name}}.name}/${aws_ecs_service.server_{{apply_name}}.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}
resource "aws_appautoscaling_policy" "ecs_policy_{{apply_name}}" {
  name               = "ecs_policy_{{apply_name}}"
  resource_id        = aws_appautoscaling_target.ecs_target_{{apply_name}}.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target_{{apply_name}}.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target_{{apply_name}}.service_namespace
  policy_type               = "TargetTrackingScaling"
  target_tracking_scaling_policy_configuration {
    target_value     = 26
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${module.alb.lb_arn_suffix}/${module.alb.target_group_arn_suffixes[{{index_{{apply_name}}}}]}"
    }
  }
}

