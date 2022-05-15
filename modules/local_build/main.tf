terraform {
  required_version = "> 0.8.0"
}

resource "null_resource" "build" {
  provisioner "local-exec" {
    command = "bash build.sh"
    # working_dir = var.working_dir
    environment = {
      region         = var.region
      ecr_url        = var.ecr_url
      registry_id    = var.registry_id
      github_url_app = var.github_url_app
      app_name       = var.app_name
      app_tag        = var.app_tag
    }
  }
}
