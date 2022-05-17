resource "aws_codebuild_project" "this" {
  name          = "cb-project-${var.env}-${var.app_name}"
  description   = "codebuild_project_${var.env}_${var.app_name}"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }
  # vpc_config {
  #   vpc_id             = var.vpc_id
  #   subnets            = var.private_subnets_id
  #   security_group_ids = [aws_security_group.codebuild_sg.id]
  # }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
    # image_pull_credentials_type = "CODEBUILD"
    environment_variable {
      name  = "ACCESS_KEY"
      value = var.aws_access_key_id
    }
    environment_variable {
      name  = "SECRET_KEY"
      value = var.aws_secret_access_key
    }

    environment_variable {
      name  = "TERRAFORM_VERSION"
      value = "1.1.9"
    }
    environment_variable {
      name  = "TERRAGRUNT_VERSION"
      value = "0.37.0"
    }
    environment_variable {
      name  = "APP_NAME"
      value = var.app_name
    }
    environment_variable {
      name  = "ENV"
      value = var.env
    }
    environment_variable {
      name  = "REGION"
      value = var.region
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "code-build-${var.env}-${var.app_name}"
      stream_name = "log-stream-cb-${var.env}-${var.app_name}"
    }
  }

  source {
    buildspec           = "env/${var.env}/buildspec.yml"
    type                = "GITHUB"
    location            = var.github_url_iac
    git_clone_depth     = 1
    report_build_status = "true"

    git_submodules_config {
      fetch_submodules = true
    }
  }
  source_version = "main"
  secondary_sources {
    type              = "GITHUB"
    location          = var.github_url_app
    source_identifier = "app"
  }

  tags = {
    Environment = "${var.env}"
  }
}
resource "aws_security_group" "codebuild_sg" {
  vpc_id = var.vpc_id
  name   = "codebuild security group"
  # dynamic "ingress" {
  #   for_each = var.sg_bas_ingress_ports
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
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "codebuild security group"
  }
}
