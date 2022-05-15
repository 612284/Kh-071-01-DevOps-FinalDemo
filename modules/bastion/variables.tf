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
  type    = string
  default = ""
}

variable "private_key_pem" {
  type    = string
  default = ""
}

variable "instance_type" {
  type    = string
  default = ""
}

variable "key_name_bastion" {
  type    = string
  default = ""
}

variable "sg_bas_ingress_ports" {
  type    = list(string)
  default = []
}
# -------------------------------
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
