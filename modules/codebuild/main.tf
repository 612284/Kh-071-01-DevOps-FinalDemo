resource "aws_codebuild_project" "this" {
  name          = "cb-project-${var.env}-${var.app_name}"
  description   = "codebuild_project_${var.env}_${var.app_name}"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:4.0"
    type         = "LINUX_CONTAINER"
    # image_pull_credentials_type = "CODEBUILD"

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
