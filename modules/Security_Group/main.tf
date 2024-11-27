resource "aws_security_group" "public" {
  name        = "Public EC2 SG"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from specific IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public EC2 SG"
  }
}

resource "aws_security_group" "private" {
  name        = "Private EC2 SG"
  description = "Allow SSH inbound traffic from public instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH from public instances"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Private EC2 SG"
  }
}