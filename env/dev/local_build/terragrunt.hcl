terraform {
  source = "../../../modules//local_build"
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

inputs = {
  ecr_url = dependency.ecr.outputs.ecr_url
  registry_id = dependency.ecr.outputs.registry_id
  # region      = var.region
  # github_url  = var.github_url
  # app_name    = var.app_name
  # app_tag     = var.app_tag
}
