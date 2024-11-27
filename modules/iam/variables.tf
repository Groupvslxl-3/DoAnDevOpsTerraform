variable "eks_cluster_role_name" {
  type = string
  description = "Role name for eks cluster"
}

variable "worker_node_role_name" {
  type = string
  description = "Role name for worker node"
}
