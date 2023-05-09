// Env (필수 기입)
env = "production"

tags = {
  Managed = "Devops"
}

// EKS Cluster
cluster_enabled_log_types              = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
cluster_version                        = "1.24"
cluster_name                           = "productioon-cluster"
enable_irsa                            = true
cluster_addons                         = []
endpoint_private_access                = true
endpoint_public_access                 = false
public_access_cidrs                    = []
cloudwatch_log_group_retention_in_days = 7