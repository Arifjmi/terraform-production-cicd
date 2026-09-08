resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash

              dnf update -y
              dnf install -y nginx

              systemctl enable nginx
              systemctl start nginx

              echo "<h1>Production Terraform CI/CD</h1>" > /usr/share/nginx/html/index.html
              echo "<p>Environment: ${var.environment}</p>" >> /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name        = "production-cicd-web-${var.environment}"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

