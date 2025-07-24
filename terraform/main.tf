provider "aws" {
  region = "eu-north-1"
}

variable "image_tag" {
  description = "Docker image tag to deploy"
  type        = string
}

resource "aws_instance" "strapi" {
  ami                    = "ami-0fe8bec493a81c7da"
  instance_type          = "t3.micro"
  key_name               = "zayn-key"
  vpc_security_group_ids = ["sg-0e0fc6d36b1f4d4ae"]

  user_data = <<-EOF
              #!/bin/bash
              exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

              echo "Updating system..."
              sudo apt update -y

              echo "Installing Docker..."
              sudo apt install -y docker.io

              echo "Starting Docker service..."
              sudo systemctl start docker

              echo "Running Strapi Docker container..."
              sudo docker run -d -p 80:1337 --name strapi ghcr.io/zayn63/strapi:${var.image_tag}

              echo "Deployment complete."
              EOF

  tags = {
    Name = "Strapi-Deployed-Instance"
  }
}

output "instance_public_ip" {
  description = "Public IP of the deployed Strapi instance"
  value       = aws_instance.strapi.public_ip
}
