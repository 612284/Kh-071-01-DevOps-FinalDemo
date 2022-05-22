terraform {
  required_version = "> 0.8.0"
}

resource "null_resource" "build" {
  provisioner "local-exec" {
    command     = "bash build.sh"
    working_dir = var.working_dir
    environment = {
      region         = var.region
      ecr_url        = var.ecr_url
      registry_id    = var.registry_id
      working_dir    = var.working_dir
      github_url_iac = var.github_url_iac
      app_name       = var.app_name
      app_tag        = var.app_tag
    }
  }
}
