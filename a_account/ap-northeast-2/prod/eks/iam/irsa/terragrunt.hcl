include "root" {
  path = find_in_parent_folders()
}

dependency "eks_cluster" {
  config_path = "../../cluster/production-cluster"
}