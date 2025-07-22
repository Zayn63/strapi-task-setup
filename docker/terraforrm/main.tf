provider "aws" {
  region = "eu-north-1"
}

resource "aws_key_pair" "zayn_key" {
  key_name   = "zayn-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "strapi_sg" {
  name        = "strapi-sg"
  description = "Allow HTTP and SSH access"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Strapi"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "strapi_ec2" {
  ami                         = "ami-0c02fb55956c7d316" # Amazon Linux 2 (or latest in your region)
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.zayn_key.key_name
  vpc_security_group_ids      = [aws_security_group.strapi_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              docker run -d -p 1337:1337 --name strapi strapi/strapi
              EOF

  tags = {
    Name = "StrapiEC2"
  }
}
