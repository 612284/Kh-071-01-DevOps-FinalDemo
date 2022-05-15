variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}
variable "env" {
  description = ""
  type        = string
  default     = ""
}
variable "app_name" {
  description = ""
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
variable "public_subnets_map" {
  description = "public subnets map"
  type = map(object({
    az   = string
    cidr = string
  }))
  # default = {
  #   subnet_1 = {
  #     az   = "eu-central-1a"
  #     cidr = "10.0.101.0/24"
  #   }
  #   subnet_2 = {
  #     az   = "eu-central-1b"
  #     cidr = "10.0.102.0/24"
  #   }
  # }
}
variable "private_subnets_map" {
  description = "private subnets map"
  type = map(object({
    az   = string
    cidr = string
  }))
  # default = {
  #   subnet_1 = {
  #   az   = "eu-central-1a"
  #   cidr = "10.0.1.0/24"
  # }
  # subnet_2 = {
  #   az   = "eu-central-1b"
  #   cidr = "10.0.2.0/24"
  # }
}
