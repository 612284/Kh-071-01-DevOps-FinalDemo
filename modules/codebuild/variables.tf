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
variable "github_url_app" {
  description = "github url app"
  type        = string
  default     = ""
}
variable "github_url_iac" {
  description = "github url infrastructure as code"
  type        = string
  default     = ""
}
variable "public_subnets_id" {
  description = "A list of public subnets id inside the VPC"
  type        = list(string)
  default     = []
}
variable "private_subnets_id" {
  description = "A list of private subnets id inside the VPC"
  type        = list(string)
  default     = []
}
variable "vpc_id" {
  description = "A list of private subnets id inside the VPC"
  type        = string
  default     = ""
}
variable "aws_access_key_id" {
  type    = string
  default = ""
}
variable "aws_secret_access_key" {
  type    = string
  default = ""
}
