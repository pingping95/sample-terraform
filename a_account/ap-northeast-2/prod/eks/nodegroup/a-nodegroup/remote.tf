locals {
  paths = [
    "cluster/production-cluster",
    "irsa/production-cluster"
  ]
}

data "terraform_remote_state" "main" {
  for_each = toset(local.paths)

  backend = "s3"

  config = {
    key = "${each.value}/terraform.tfstate"

    bucket = local.backend_s3
    region = local.backend_s3_region

    role_arn = local.backend_role_arn
  }
}