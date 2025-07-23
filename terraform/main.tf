provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "strapi" {
  ami                    = "ami-0fe8bec493a81c7da"
  instance_type          = "t3.micro"
  key_name               = "zayn-key"
  vpc_security_group_ids = ["sg-0e0fc6d36b1f4d4ae"]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y docker.io
              systemctl start docker
              docker run -d -p 80:1337 --name strapi ${var.docker_image}
              EOF

  tags = {
    Name = "Strapi-Deployed-Instance"
  }
}
