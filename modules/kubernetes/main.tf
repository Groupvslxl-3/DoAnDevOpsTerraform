data "aws_iam_user" "group15" {
  user_name = "khoedi"
}

resource "kubernetes_config_map" "aws_auth1" {
  metadata {
    name      = "aws-auth1"
    namespace = "kube-system"
  }

  data = { 
    mapUsers = <<EOT
      - userarn: ${data.aws_iam_user.group15.arn}
      - username: ${data.aws_iam_user.group15.user_name}
    groups: 
      - system:masters
EOT
  }
}

resource "kubernetes_role_binding" "rbac_binding" {
  metadata {
    name      = "rbac-role-binding"
    namespace = "default"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.admin_role.metadata[0].name
  }

  subject {
    kind      = "User"
    name      = data.aws_iam_user.group15.user_name
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_cluster_role" "admin_role" {
  metadata {
    name = "admin-role"
  }

  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

# resource "kubernetes_config_map" "aws_auth" {
#   metadata {
#     name      = "aws-auth"
#     namespace = "kube-system"
#   }

#   data = {
#     mapRoles = <<EOT
# - rolearn: ${data.aws_iam_role.eks_role.arn}
#   username: system:node:{{EC2PrivateDNSName}}
#   groups:
#     - system:bootstrappers
#     - system:nodes
# - rolearn: ${data.aws_iam_user.group15.arn}
#   username: ${data.aws_iam_user.group15.user_name}
#   groups:
#     - system:masters
# EOT
#   }
# }