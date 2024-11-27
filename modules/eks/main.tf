resource "aws_eks_cluster" "this" {
  name = var.cluster_name
  role_arn = var.cluster_role_arn

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids = concat(var.public_subnet_ids, var.private_subnet_ids)
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
}

resource "aws_eks_node_group" "public" {
  cluster_name = aws_eks_cluster.this.name
  node_group_name = var.public_node_group_name
  node_role_arn = var.node_group_role_arn
  subnet_ids = var.public_subnet_ids
  instance_types = var.instance_types

  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key = var.key_name
  }

  scaling_config {
    desired_size = 1
    min_size = 1
    max_size = 2
  }
}

resource "aws_eks_node_group" "private" {
  cluster_name = aws_eks_cluster.this.name
  node_group_name = var.private_node_group_name
  node_role_arn = var.node_group_role_arn
  subnet_ids = var.private_subnet_ids
  instance_types = var.instance_types

  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key = var.key_name
  }

  scaling_config {
    desired_size = 1
    min_size = 1
    max_size = 2
  }
}

// Create IAM role for service account
data "tls_certificate" "tls" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "openid_connect_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.tls.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.tls.url
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.openid_connect_provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.openid_connect_provider.arn]
      type        = "Federated"
    }
  }
}