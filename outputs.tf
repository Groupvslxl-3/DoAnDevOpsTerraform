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

# output "public_instance_ips" {
#   value = module.ec2.public_instance_ips
# }

# output "private_instance_ips" {
#   value = module.ec2.private_instance_ips
# }