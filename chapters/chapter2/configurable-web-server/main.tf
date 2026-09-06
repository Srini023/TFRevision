provider "aws" {
  region                      = "us-east-2"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

resource "aws_instance" "example" {
  ami                    = "ami-0fb653ca2d3203ac1" 
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  # 💡 Interpolated variable reference inside your bash script
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  # Recommended in the book to force replacement when user_data changes
  user_data_replace_on_change = true

  tags = {
    Name = "terraform-configurable-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-configurable-instance"

  ingress {
    # 💡 Dynamically reading from your variables file
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

