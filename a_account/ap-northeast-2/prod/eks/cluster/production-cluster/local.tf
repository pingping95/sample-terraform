locals {

  // Cluster Version
  cluster_version           = var.cluster_version
  cluster_name              = var.cluster_name
  cluster_enabled_log_types = var.cluster_enabled_log_types
  enable_irsa               = var.enable_irsa

  // Cluster 애드온
  cluster_addons = var.cluster_addons

  // k8s Endpoint 설정
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  public_access_cidrs     = var.public_access_cidrs

  // CW Logs 보관 기관
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days

  // Tags
  cluster_tags = {}
}