locals {
  region                = "eu-west-1"
  profile               = "default"
  cidr                  = "10.10.0.0/16"
  instance_type         = "t2.micro"
  sg_alb_ingress_ports  = ["80"]
  github_url            = "https://github.com/612284/Kh-071-01-DevOps-FinalDemo.git"
  app_name              = "flask"
  app_tag               = "1"
  env                   = "prod"
  build_count           = 10
  github_event          = "PUSH, PULL_REQUEST_CREATED, PULL_REQUEST_UPDATED, PULL_REQUEST_MERGED"
  github_head_ref       = "^refs/tags/prod-.*"
  github_commit_message = "version"
  github_branch         = "main"
  private_subnets_map = {
    subnet_1 = {
      az   = "${local.region}a"
      cidr = "10.10.1.0/24"
    }
    # subnet_2 = {
    #   az   = "${local.region}b"
    #   cidr = "10.10.2.0/24"
    # }
  }
  public_subnets_map = {
    subnet_1 = {
      az   = "${local.region}a"
      cidr = "10.10.101.0/24"
    }
    subnet_2 = {
      az   = "${local.region}b"
      cidr = "10.10.102.0/24"
    }
  }
  codebuild_env_vars = {
      TERRAFORM_VERSION  = "1.1.9"
      TERRAGRUNT_VERSION = "0.37.0"
      APP_NAME           = "${local.app_name}"
      ENV                = "${local.env}"
      AWS_DEFAULT_REGION = "${local.region}"
  }
}

# Indicate the input values to use for the variables of the module.
inputs = {
  region                = local.region
  profile               = local.profile
  cidr                  = local.cidr
  instance_type         = local.instance_type
  sg_alb_ingress_ports  = local.sg_alb_ingress_ports
  github_url            = local.github_url
  app_name              = local.app_name
  app_tag               = local.app_tag
  env                   = local.env
  build_count           = local.build_count
  github_event          = local.github_event
  github_head_ref       = local.github_head_ref
  github_commit_message = local.github_commit_message
  github_branch         = local.github_branch
  private_subnets_map   = local.private_subnets_map
  public_subnets_map    = local.public_subnets_map
  codebuild_env_vars    = local.codebuild_env_vars

  tags = {
    Terraform = "true"
    Environment = "${local.env}"
  }
}
remote_state {
  backend = "s3"

  config = {
    bucket         = "my-terraform-state-${local.env}-${local.app_name}-${local.region}"
    profile        = "${local.profile}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.region}"
    encrypt        = true
    dynamodb_table = "my-lock-table-${local.env}-${local.app_name}"
  }
}

terraform {
  after_hook "remove_lock" {
    commands = [
      "apply",
      "console",
      "destroy",
      "import",
      "init",
      "plan",
      "push",
      "refresh",
    ]

    execute = [
      "rm",
      "-f",
      "${get_terragrunt_dir()}/.terraform.lock.hcl",
    ]

    run_on_error = true
  }
}

terraform_version_constraint = "1.1.9"

terragrunt_version_constraint = ">= 0.37.0"
