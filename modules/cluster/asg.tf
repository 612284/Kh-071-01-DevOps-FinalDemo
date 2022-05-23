resource "aws_launch_template" "worker_template" {
  name                    = "worker-template-${var.env}-${var.app_name}"
  disable_api_termination = false
  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_agent.name
  }
  image_id                             = data.aws_ami.latest_amason_linyx.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance_type
  vpc_security_group_ids               = [aws_security_group.worker.id]

  user_data = base64encode(
    templatefile(
      "launch_tmpl_usr_data.sh",
      {
        env      = var.env,
        app_name = var.app_name
      }
    )
  )
}

resource "aws_autoscaling_group" "ecs_asg" {
  name                      = "asg-${var.env}-${var.app_name}"
  vpc_zone_identifier       = var.public_subnets_id
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  tag {
    key                 = "Name"
    value               = "worker-${var.env}-${var.app_name}"
    propagate_at_launch = true
  }
  launch_template {
    id      = aws_launch_template.worker_template.id
    version = "$Latest"
  }
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"
}

resource "aws_autoscaling_policy" "web_policy_up" {
  name                   = "policy-up-${var.env}-${var.app_name}"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ecs_asg.name
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
  alarm_name          = "cpu-alarm-up-${var.env}-${var.app_name}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ecs_asg.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.web_policy_up.arn]
}
resource "aws_autoscaling_policy" "web_policy_down" {
  name                   = "policy-down-${var.env}-${var.app_name}"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ecs_asg.name
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
  alarm_name          = "cpu-alarm-down-${var.env}-${var.app_name}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ecs_asg.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.web_policy_down.arn]
}

resource "aws_security_group" "worker" {
  vpc_id = var.vpc_id
  name   = "worker-sg-${var.env}-${var.app_name}"

  # dynamic "ingress" {
  #   for_each = var.sg_asg_ingress_ports
  #   content {
  #     from_port   = ingress.value
  #     to_port     = ingress.value
  #     protocol    = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }
  # }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "worker-sg-${var.env}-${var.app_name}"
  }
}

data "aws_ami" "latest_amason_linyx" {
  owners      = ["591542846629"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}
