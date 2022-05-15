resource "aws_alb" "this" {
  name               = "alb-tf-${var.env}-${var.app_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnets_id

  tags = {
    Environment = "${var.env}"
  }
}

resource "aws_alb_target_group" "asg-target-group" {
  name        = "alb-tg-${var.env}-${var.app_name}"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_security_group" "alb" {
  name        = "terraform-alb-80-${var.env}-${var.app_name}"
  description = "Allow 80"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_alb_ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
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
    Name = "terraform-alb-80"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.asg-target-group.id
    type             = "forward"
  }
}
