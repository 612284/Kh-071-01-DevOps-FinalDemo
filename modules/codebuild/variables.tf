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
variable "AWS_ACCESS_KEY_ID" {
  type    = string
  default = ""
}
variable "AWS_SECRET_ACCESS_KEY" {
  type    = string
  default = ""
}
variable "profile" {
  description = ""
  type        = string
  default     = ""
}
