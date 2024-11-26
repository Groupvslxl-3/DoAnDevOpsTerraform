# Create Elastic IPs
resource "aws_eip" "service_1_eip" {
  domain = "vpc"
  tags = {
    Name = "Service 1 EIP"
  }
}

resource "aws_eip" "service_2_eip" {
  domain = "vpc"
  tags = {
    Name = "Service 2 EIP"
  }
}

resource "aws_eip" "service_3_eip" {
  domain = "vpc"
  tags = {
    Name = "Service 3 EIP"
  }
}