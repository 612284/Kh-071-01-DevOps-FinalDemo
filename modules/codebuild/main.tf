resource "aws_codebuild_source_credential" "this" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = var.github_token
}

resource "aws_codebuild_project" "this" {
  depends_on = [aws_codebuild_source_credential.this]

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
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    image_pull_credentials_type = "CODEBUILD"

    dynamic "environment_variable" {
      for_each = var.codebuild_env_vars
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
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
    location            = var.github_url
    git_clone_depth     = 1
    report_build_status = "true"
    git_submodules_config {
      fetch_submodules = true
    }
  }
  source_version = var.github_branch
  tags = {
    Environment = "${var.env}"
  }
}
resource "aws_codebuild_webhook" "webhook" {
  project_name = aws_codebuild_project.this.name
  filter_group {
    filter {
      type    = "EVENT"
      pattern = var.github_event
    }
    filter {
      type    = "HEAD_REF"
      pattern = var.github_head_ref
    }
  }
}

resource "aws_security_group" "codebuild_sg" {
  vpc_id = var.vpc_id
  name   = "codebuild security group"
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
    Name = "codebuild-sg-${var.env}-${var.app_name}"
  }
}
