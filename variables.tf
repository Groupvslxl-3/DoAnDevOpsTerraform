variable "region" {
  description = "AWS region"
  type        = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]

}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default = [ "10.0.3.0/24", "10.0.4.0/24" ]
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default = [ "us-east-1a", "us-east-1b" ]
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default = "ami-0866a3c8686eaeeba"
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
  default = "t2.micro"
}

variable "public_instance_count" {
  description = "Number of public EC2 instances"
  type        = number
  default = 1
}

variable "private_instance_count" {
  description = "Number of private EC2 instances"
  type        = number
  default = 1
}

variable "my_ip" {
  description = "Your IP address"
  type        = string
  default = "14.186.212.48/32"
}

variable "id_ed25519_pub" {
  description = "Public key for SSH access"
  type        = string
}

variable "key_name" {
  description = "Public key for SSH access"
  type        = string
  default = "lxlso1"
}

variable "eks_cluster_role_name" {
  type = string
  description = "Role name for eks cluster"
  default = "group15-eks-cluster-role"
}

variable "worker_node_role_name" {
  type = string
  description = "Role name for worker node"
  default = "group15-worker-node-role"
}

variable "cluster_name" {
  type = string
  description = "Name of a cluster"
  default = "group15-cluster"
}


variable "public_node_group_name" {
  type = string
  description = "Name of a public node group"
  default = "group15-public-node-group"
}

variable "private_node_group_name" {
  type = string
  description = "Name of a private node group"
  default = "group15-private-node-group"
}


variable "instance_types" {
  type = list(string)
  description = "List of instance types for node group"
  default = [ "t3.medium" ]
}

