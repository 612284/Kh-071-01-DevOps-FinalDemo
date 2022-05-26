resource "aws_ecs_cluster" "ecs_cluster" {
  name = "cluster-${var.env}-${var.app_name}"
}

resource "aws_ecs_service" "worker" {
  name                               = "worker-${var.env}-${var.app_name}"
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.task_definition.arn
  desired_count                      = 4
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  force_new_deployment               = true

  load_balancer {
    target_group_arn = aws_alb_target_group.asg-target-group.arn
    container_name   = aws_ecs_task_definition.task_definition.family
    container_port   = 5000
  }
}
