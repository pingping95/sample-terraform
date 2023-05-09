locals {
  // EKS Cluster
  cluster_name = data.terraform_remote_state.main["cluster/production-cluster"].outputs.cluster_id

  // NodeGroup Role
  nodegroup_role_arn = data.terraform_remote_state.main["iam/production-cluster"].outputs.nodegroup_role_arn

  // 변수
  launch_template = {
    image_id      = var.launch_template_image_id
    instance_type = var.launch_template_instance_type
    key_name      = var.launch_template_key_name
  }

  nodegroup = {
    name         = var.nodegroup_name
    desired_size = var.nodegroup_desired_size
    min_size     = var.nodegroup_min_size
    max_size     = var.nodegroup_max_size
    lt_version   = var.nodegroup_lt_version
  }
}