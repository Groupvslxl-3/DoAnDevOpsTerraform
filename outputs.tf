output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.my_security_group.id
}

output "eks_cluster_endpoint" {
  value       = aws_eks_cluster.main.endpoint
  description = "EKS cluster endpoint"
}

output "eks_cluster_name" {
  value       = aws_eks_cluster.main.name
  description = "EKS cluster name"
}

output "eks_cluster_security_group_id" {
  value       = aws_security_group.eks_sg.id
  description = "Security group ID for EKS cluster"
}

output "frontend_service_endpoint" {
  value       = try(kubernetes_service.frontend.status.0.load_balancer.0.ingress.0.hostname, "pending")
  description = "Frontend LoadBalancer Endpoint"
  depends_on  = [kubernetes_service.frontend]
}

output "backend_service_endpoint" {
  value       = try(kubernetes_service.backend.status.0.load_balancer.0.ingress.0.hostname, "pending")
  description = "Backend LoadBalancer Endpoint"
  depends_on  = [kubernetes_service.backend]
}

output "admin_service_endpoint" {
  value       = try(kubernetes_service.admin.status.0.load_balancer.0.ingress.0.hostname, "pending")
  description = "Admin LoadBalancer Endpoint"
  depends_on  = [kubernetes_service.admin]
}
    