terraform {
  source = "../../../modules//codebuild"
}
include {
  path = find_in_parent_folders()
}
dependencies {
    paths = ["../claster"]
}
# inputs = {
#     # vpc_id = dependency.cluster.outputs.vpc_id
#     # subnets = dependency.cluster.outputs.subnets
#     build_spec = "env/dev/buildspec.yml"
# }
