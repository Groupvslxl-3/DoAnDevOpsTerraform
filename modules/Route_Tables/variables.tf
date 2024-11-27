variable "vpc_id" {
  description = "ID của VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "Danh sách ID của public subnets"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Danh sách ID của private subnets"
  type        = list(string)
}

variable "internet_gateway_id" {
  description = "ID của Internet Gateway"
  type        = string
}

variable "nat_gateway_ids" {
  description = "Danh sách ID của NAT Gateways"
  type        = list(string)
}