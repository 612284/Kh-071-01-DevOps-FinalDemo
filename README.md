# This is a simple CI/CD built by Terragrunt for two environments using AWS VPC, Codebuild, ECR, and ECS  

### each project environment contains:

- 2 public subnets
- 2 private subnets
- Internet getaway
- 2 NAT
- Application load balancer
- Autoscaling group
- EC2 instance for init build
- Codebuild
- ECR and ECS

![](img/1.png)

### CI/CD

![](img/2.png)

### for run you need:

1 installed terraform, terragrunt and git

2 clone this repository
```
git clone <https://github.com/612284/Kh-071-01-DevOps-FinalDemo>
```
3 enter your variables in local block in env/dev/terragrunt.hcl file and env/prod/terragrunt.hcl
```
locals {
  region                = "eu-central-1"
  profile               = "default"
  cidr                  = "10.0.0.0/16"
  instance_type         = "t2.micro"
  sg_alb_ingress_ports  = ["80"]
  github_url            = "https://github.com/612284/Kh-071-01-DevOps-FinalDemo.git"
  app_name              = "flask"
  app_tag               = "1"
  env                   = "dev"
  build_count           = 10
  github_event          = "PUSH"
  github_head_ref       = "dev"
  github_branch         = "dev"
  private_subnets_map = {
    subnet_1 = {
      az   = "${local.region}a"
      cidr = "10.0.1.0/24"
    }
     subnet_2 = {
       az   = "${local.region}b"
       cidr = "10.0.2.0/24"
     }
  }
  public_subnets_map = {
    subnet_1 = {
      az   = "${local.region}a"
      cidr = "10.0.101.0/24"
    }
    subnet_2 = {
      az   = "${local.region}b"
      cidr = "10.0.102.0/24"
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
```
4 to add AWS credentials for example create 2 files
~/.aws/credentials
```
[default]
aws_access_key_id = your_access_key_id
aws_secret_access_key = your_secret_access_key
```
~/.aws/config
```
[default]
region = your_aws_region # must be the same as a region in  terragrunt.hcl file
```
or run in terminal
```
export AWS_ACCESS_KEY_ID=your_access_key_id
export AWS_SECRET_ACCESS_KEY=your_secret_access_key
export AWS_REGION=your_aws_region # must be the same as a region in  terragrunt.hcl file
```
5 create two files env/dev/secrets.hcl and env/prod/secrets.hcl
```
inputs = {
github_token = "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" # your github token
}
```

6 run Terragrunt
```
terragrunt run-all plan
terraform run-all apply
```
