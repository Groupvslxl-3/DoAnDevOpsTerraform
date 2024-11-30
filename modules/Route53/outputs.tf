output "name_servers" {
  description = "Name servers của hosted zone"
  value       = data.aws_route53_zone.selected.name_servers
}

output "zone_id" {
  description = "Zone ID của hosted zone"
  value       = data.aws_route53_zone.selected.zone_id
}

output "domain_name" {
  description = "Tên domain"
  value       = data.aws_route53_zone.selected.name
}