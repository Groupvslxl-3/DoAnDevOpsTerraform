variable "cluster_name" {
  type = string
  description = "Name of a cluster"
}

variable "cluster_role_arn" {
  type = string
  description = "ARN of a cluster role"
}

variable "public_subnet_ids" {
  type = list(string)
  description = "Set of public subnet ids"
}

variable "private_subnet_ids" {
  type = list(string)
  description = "Set of private subnet ids"
}

variable "public_node_group_name" {
  type = string
  description = "Name of a public node group"
}

variable "private_node_group_name" {
  type = string
  description = "Name of a private node group"
}

variable "node_group_role_arn" {
  type = string
  description = "ARN of a node group role"
}

variable "instance_types" {
  type = list(string)
  description = "List of instance types for node group"
  default = [ "t3.medium" ]
}

variable "key_name" {
  type = string
  description = "Key name for ssh EC2 instance"
}