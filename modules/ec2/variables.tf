variable "ami_id" {
  description = "ID của AMI để sử dụng cho các instance"
  type        = string
}

variable "instance_type" {
  description = "Loại instance EC2"
  type        = string
}

variable "public_subnet_ids" {
  description = "Danh sách các ID của public subnet"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Danh sách các ID của private subnet"
  type        = list(string)
}

variable "public_sg_id" {
  description = "ID của security group cho public instances"
  type        = string
}

variable "private_sg_id" {
  description = "ID của security group cho private instances"
  type        = string
}

variable "key_name" {
  description = "Tên của key pair để sử dụng cho các instance"
  type        = string
}

variable "public_instance_count" {
  description = "Số lượng public instances cần tạo"
  type        = number
}

variable "private_instance_count" {
  description = "Số lượng private instances cần tạo"
  type        = number
}