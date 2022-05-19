locals {
  region               = "eu-central-1"
  profile              = "default"
  cidr                 = "10.10.0.0/16"
  instance_type        = "t2.micro"
  sg_alb_ingress_ports = ["80"]
  sg_asg_ingress_ports = ["49153", "49154", "49155", "49156", "49157"]
  github_url_app       = "https://github.com/612284/flask-app.git"
  github_url_iac       = "https://github.com/612284/Kh-071-01-DevOps-FinalDemo.git"
  app_name             = "flask"
  app_tag              = "1"
  env                  = "prod"
  private_subnets_map = {
    subnet_1 = {
      az   = "eu-central-1a"
      cidr = "10.10.1.0/24"
    }
    subnet_2 = {
      az   = "eu-central-1b"
      cidr = "10.10.2.0/24"
    }
  }
  public_subnets_map = {
    subnet_1 = {
      az   = "eu-central-1a"
      cidr = "10.10.101.0/24"
    }
    subnet_2 = {
      az   = "eu-central-1b"
      cidr = "10.10.102.0/24"
    }
  }
}

# Indicate the input values to use for the variables of the module.
inputs = {
  region               = local.region
  profile              = local.profile
  cidr                 = local.cidr
  instance_type        = local.instance_type
  sg_alb_ingress_ports = local.sg_alb_ingress_ports
  sg_asg_ingress_ports = local.sg_asg_ingress_ports
  github_url_app       = local.github_url_app
  github_url_iac       = local.github_url_iac
  app_name             = local.app_name
  app_tag              = local.app_tag
  env                  = local.env
  private_subnets_map  = local.private_subnets_map
  public_subnets_map   = local.public_subnets_map

  tags = {
    Terraform = "true"
    Environment = "${local.env}"
  }
}
remote_state {
  backend = "s3"

  config = {
    bucket         = "my-terraform-state-${local.env}-${local.app_name}"
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
