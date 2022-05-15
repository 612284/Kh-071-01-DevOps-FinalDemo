resource "aws_ecs_task_definition" "task_definition" {
  family                   = "worker-${var.env}-${var.app_name}"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  container_definitions    = data.template_file.task_definition_template.rendered
}
data "template_file" "task_definition_template" {
  template = templatefile("task_definition.json.tpl", {
    ecr_url  = var.ecr_url,
    app_tag  = var.app_tag,
    region   = var.region,
    app_name = var.app_name,
    env      = var.env
  })
}

resource "aws_cloudwatch_log_group" "awslogs-group" {
  name = "${var.env}-${var.app_name}-group"
}

resource "aws_cloudwatch_log_stream" "awslogs-stream" {
  name           = "${var.env}-${var.app_name}-stream"
  log_group_name = aws_cloudwatch_log_group.awslogs-group.name
}
