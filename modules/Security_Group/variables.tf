variable "vpc_id" {
  description = "ID của VPC mà security groups sẽ được tạo"
  type        = string
}

variable "my_ip" {
  description = "Địa chỉ IP được phép truy cập SSH vào public instances"
  type        = string
}