resource "aws_instance" "public" {
  count                  = var.public_instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[count.index]
  vpc_security_group_ids = [var.public_sg_id]
  key_name               = var.key_name

  tags = {
    Name = "Public EC2 ${count.index + 1}"
  }

  # provisioner "file" {
  #   source      = "~/.ssh/id_ed25519"
  #   destination = "/home/ubuntu/.ssh/id_ed25519"

  #   connection {
  #     type        = "ssh"
  #     host        = self.public_ip
  #     user        = "ubuntu"
  #     private_key = file("~/.ssh/id_ed25519")
  #   }
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod 600 /home/ubuntu/.ssh/id_ed25519",
  #   ]

  #   connection {
  #     type        = "ssh"
  #     host        = self.public_ip
  #     user        = "ubuntu"
  #     private_key = file("~/.ssh/id_ed25519")
  #   }
  # }
}

resource "aws_instance" "private" {
  count                  = var.private_instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [var.private_sg_id]
  key_name               = var.key_name

  tags = {
    Name = "Private EC2 ${count.index + 1}"
  }
}
