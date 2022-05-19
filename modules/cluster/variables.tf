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
variable "sg_alb_ingress_ports" {
  type    = list(string)
  default = []
}
variable "sg_asg_ingress_ports" {
  type    = list(string)
  default = []
}
variable "alb_dns_name" {
  type    = string
  default = ""
}
variable "target_group_arns" {
  type    = string
  default = ""
}
variable "ecr_url" {
  description = "ecr url"
  type        = string
  default     = ""
}
variable "app_tag" {
  description = "app tag"
  type        = string
  default     = ""
}
variable "generated_key_name" {
  description = "generated keyname"
  type        = string
  default     = ""
}
variable "instance_type" {
  description = "instance type"
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
variable "profile" {
  description = ""
  type        = string
  default     = ""
}
