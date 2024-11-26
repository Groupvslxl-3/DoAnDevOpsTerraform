provider "kubernetes" {
  host                   = aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.main.name]
    command     = "aws"
  }
}

# Frontend Deployment
resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "frontend"
      }
    }
    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }
      spec {
        container {
          name  = "frontend"
          image = "pokilee10/jenkins_frontend:latest"
          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

# Backend Deployment
resource "kubernetes_deployment" "backend" {
  metadata {
    name = "backend"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "backend"
      }
    }
    template {
      metadata {
        labels = {
          app = "backend"
        }
      }
      spec {
        container {
          name  = "backend"
          image = "pokilee10/jenkins_backend:latest"
          port {
            container_port = 4000
          }
        }
      }
    }
  }
}

# Admin Deployment
resource "kubernetes_deployment" "admin" {
  metadata {
    name = "admin"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "admin"
      }
    }
    template {
      metadata {
        labels = {
          app = "admin"
        }
      }
      spec {
        container {
          name  = "admin"
          image = "pokilee10/jenkins_admin:latest"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

# Services
resource "kubernetes_service" "frontend" {
  metadata {
    name = "frontend"
  }
  spec {
    selector = {
      app = "frontend"
    }
    port {
      port        = 80
      target_port = 3000
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_service" "backend" {
  metadata {
    name = "backend"
  }
  spec {
    selector = {
      app = "backend"
    }
    port {
      port        = 80
      target_port = 4000
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_service" "admin" {
  metadata {
    name = "admin"
  }
  spec {
    selector = {
      app = "admin"
    }
    port {
      port        = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
} 