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
  
  # Connect the server to our web security group below
  vpc_security_group_ids = [aws_security_group.instance.id]

  # Bash script that kicks off a mini web server on startup
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-web-server-example"
  }
}

# The Security Group resource enabling external incoming port 8080 traffic
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

