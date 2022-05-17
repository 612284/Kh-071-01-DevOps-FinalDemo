terraform {
  backend "s3" {
    bucket         = "my-terraform-state-dev-flask"
    dynamodb_table = "my-lock-table-dev-flask"
    encrypt        = true
    key            = "claster/terraform.tfstate"
    region         = "eu-central-1"
  }
}
