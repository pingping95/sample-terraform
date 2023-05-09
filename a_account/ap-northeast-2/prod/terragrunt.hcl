remote_state {
  backend = "s3"
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    region          = "ap-northeast-2"
    encrypt         = true
    role_arn        = "my-role-arn-to-auth-bucket"

    bucket          = "my-terraform-state-bucket"
    key             = "${path_relative_to_include()}/terraform.tfstate"
    dynamodb_table  = "my-terraform-dynamodb-lock-table"
  }
}

generate "provider" {
  path = "_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "ap-northeast-2"
  assume_role {
    role_arn     = "my-role-arn-to-assume-a_account"
    session_name = "DEVOPS_SESSION"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.8.0"
    }
  }
}

EOF
}


// Sandbox 파트 공용 변수
generate "shared_config" {
  path = "_shared_config.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
// Shared Locals
locals {
  region    = var.region
  account   = var.account
  env       = var.env
  tags = merge(
    {
      Managed = "Terraform"
    },
    var.tags,
  )

  name_prefix = format("my-%s-%s-seoul", var.account, var.env)

  // Backend S3, DynamoDB for Remote State
  backend_s3        = var.backend_s3
  backend_dynamodb  = var.backend_dynamodb
  backend_s3_region = var.backend_s3_region
  backend_role_arn  = "my-backend-role-arn"

  // 개발계 VPC
  vpc_id = var.vpc_id
  vpc_cidr = var.vpc_cidr
  private_subnet_ids = var.private_subnet_ids
  a-nodegroup-sg_id = var.a-nodegroup-sg_id
}

// Shared Variables
variable "account" { default = "a_account" } # Required in tfvars file
variable "region" { default = "ap-northeast-2" }  # Required in tfvars file
variable "env" {} # tfvars 파일에서 지정
variable "tags" { default = {} }
variable "backend_s3" { default = "my-terraform-state-bucket" }
variable "backend_s3_region" { default = "ap-northeast-2" }
variable "backend_dynamodb" { default = "my-terraform-dynamodb-lock-table" }

// 개발계 공용 변수
variable "vpc_id" { default = "my-vpc" }
variable "vpc_cidr" { default = "my-vpc-cidr" }
variable "private_subnet_ids" {
  // private_eks_node_subnet_ids 2a, 2c
  default = ["my-private-subnet-id1s", "my-private-subnet-ids2"]
}

variable "a-nodegroup-sg_id" { default = "sg-xxxx" }

EOF
}