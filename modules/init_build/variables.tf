variable "region" {
  description = "region"
  type        = string
  default     = ""
}
variable "ecr_url" {
  description = "ecr url"
  type        = string
  default     = ""
}
variable "registry_id" {
  description = "registry id"
  type        = string
  default     = ""
}
variable "github_url" {
  description = "github url"
  type        = string
  default     = ""
}
variable "github_branch" {
  description = "github branch"
  type        = string
  default     = ""
}
variable "app_name" {
  description = "app name"
  type        = string
  default     = ""
}
variable "app_tag" {
  description = "app tag"
  type        = string
  default     = ""
}
variable "profile" {
  description = ""
  type        = string
  default     = ""
}
variable "working_dir" {
  description = ""
  type        = string
  default     = ""
}
variable "instance_type" {
  description = "instance type"
  type        = string
  default     = ""
}
variable "vpc_id" {
  description = "A list of private subnets id inside the VPC"
  type        = string
  default     = ""
}
variable "public_subnets_id" {
  description = "A list of public subnets id inside the VPC"
  type        = list(string)
  default     = []
}
variable "env" {
  description = ""
  type        = string
  default     = ""
}
