output "vpc_id" {
  value = module.VPC.vpc_id
}

output "public_subnet_ids" {
  value = module.VPC.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.VPC.private_subnet_ids
}

output "default_security_group_id" {
  value = module.VPC.default_security_group_id
}

output "route53_name_servers" {
  description = "Name servers của Route53 hosted zone"
  value       = module.Route53.name_servers
}

output "route53_zone_id" {
  description = "Zone ID của Route53 hosted zone"
  value       = module.Route53.zone_id
}

output "domain_name" {
  description = "Tên domain"
  value       = module.Route53.domain_name
}