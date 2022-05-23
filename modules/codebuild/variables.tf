variable "profile" {
  description = ""
  type        = string
  default     = ""
}
variable "region" {
  description = "region"
  type        = string
  default     = ""
}
variable "app_name" {
  description = "app name"
  type        = string
  default     = ""
}
variable "env" {
  description = ""
  type        = string
  default     = ""
}

variable "github_token" {
  description = "github token"
  type        = string
  default     = ""
}
variable "github_url" {
  description = "github url"
  type        = string
  default     = ""
}
variable "vpc_id" {
  description = "A list of private subnets id inside the VPC"
  type        = string
  default     = ""
}
variable "github_event" {
  description = ""
  type        = string
  default     = ""
}
variable "github_head_ref" {
  description = ""
  type        = string
  default     = ""
}
variable "github_commit_message" {
  description = ""
  type        = string
  default     = ""
}
variable "github_branch" {
  description = ""
  type        = string
  default     = ""
}
variable "private_subnets_id" {
  description = "A list of private subnets id inside the VPC"
  type        = list(string)
  default     = []
}
variable "codebuild_env_vars" {
  type = map(any)
  # default = {
  #   TERRAFORM_VERSION  = "1.1.9"
  #   TERRAGRUNT_VERSION = "0.37.0"
  #   APP_NAME           = "flask"
  #   ENV                = ""
  #   AWS_DEFAULT_REGION = ""
  # }
}
