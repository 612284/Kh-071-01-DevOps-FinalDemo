resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.latest_amason_linyx.id
  instance_type          = var.instance_type
  key_name               = var.key_name_bastion
  subnet_id              = var.public_subnets_id[0]
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  # user_data              = data.template_file.user_data.rendered
  tags = {
    Name = "bastion"
  }
}

data "template_file" "user_data" {
  template = templatefile("user_data.tftpl", {
    # private_key_pem = var.private_key_pem
    region             = var.region
    ecr_url            = var.ecr_url
    registry_id        = var.registry_id
    github_url         = var.github_url
    app_name           = var.app_name
    app_tag            = var.app_tag
    default_access_key = ""
    default_secret_key = ""
  })
}

resource "aws_security_group" "bastion_sg" {
  vpc_id = var.vpc_id
  name   = "bastion security group"
  dynamic "ingress" {
    for_each = var.sg_bas_ingress_ports
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
    Name = "bastion security group"
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
