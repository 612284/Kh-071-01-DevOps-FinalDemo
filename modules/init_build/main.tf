resource "aws_instance" "this" {
  ami                    = data.aws_ami.latest_amason_linyx.id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnets_id[0]
  vpc_security_group_ids = [aws_security_group.this.id]
  user_data              = data.template_file.user_data.rendered
  iam_instance_profile   = aws_iam_instance_profile.this.name
  tags = {
    Name = "init-${var.env}-${var.app_name}"
  }
}

data "template_file" "user_data" {
  template = templatefile("build.sh", {
    region        = var.region
    ecr_url       = var.ecr_url
    registry_id   = var.registry_id
    github_url    = var.github_url
    github_branch = var.github_branch
    app_name      = var.app_name
    app_tag       = var.app_tag
  })
}

resource "aws_security_group" "this" {
  vpc_id = var.vpc_id
  name   = "init-sg-${var.env}-${var.app_name}"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "init-sg-${var.env}-${var.app_name}"
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
