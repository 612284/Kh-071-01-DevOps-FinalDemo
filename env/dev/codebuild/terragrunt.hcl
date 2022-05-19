terraform {
  source = "../../../modules//codebuild"
}
include {
  path = find_in_parent_folders()
}
dependencies {
    paths = ["../cluster"]
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id = "vpc-000000000000"
    public_subnets_id = ["subnet-00000000000","subnet-00000000001" ]
    private_subnets_id = ["subnet-00000000002", "subnet-00000000003"]
  }
}
locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("secrets.hcl"))
}

inputs = merge(
  local.common_vars.inputs,{
  private_subnets_id = dependency.vpc.outputs.private_subnets_id
  public_subnets_id = dependency.vpc.outputs.public_subnets_id
  vpc_id = dependency.vpc.outputs.vpc_id
})
