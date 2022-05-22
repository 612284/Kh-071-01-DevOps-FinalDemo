terraform {
  source = "../../../modules//init_build"
}
include {
  path = find_in_parent_folders()
}
dependency "ecr" {
  config_path = "../ecr"
  mock_outputs = {
  ecr_url = "000000000000.dkr.ecr.eu-west-1.amazonaws.com/image"
  registry_id = "000000000000"
  }
  # skip_outputs = true
}
dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id = "vpc-000000000000"
    public_subnets_id = ["subnet-00000000000","subnet-00000000001" ]
  }
}


inputs = {
  ecr_url = dependency.ecr.outputs.ecr_url
  registry_id = dependency.ecr.outputs.registry_id
  public_subnets_id = dependency.vpc.outputs.public_subnets_id
  vpc_id = dependency.vpc.outputs.vpc_id
}
