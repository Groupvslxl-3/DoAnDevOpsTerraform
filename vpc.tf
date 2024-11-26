# Tạo VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Main VPC"
  }
}

# Tạo public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"  # Thay đổi CIDR block theo nhu cầu của bạn
  availability_zone = "ap-southeast-1a"  # Thay đổi AZ theo region của bạn
  
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
} 