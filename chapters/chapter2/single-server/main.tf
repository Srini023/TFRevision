provider "aws" {
  region = "us-east-2"
  
  # 💡 THE SECRET TRICK: These mock inputs tell Terraform to bypass 
  # credential checks so you can run structural commands offline.
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

resource "aws_instance" "example" {
  ami           = "ami-0fb653ca2d3203ac1" # Ubuntu 20.04 LTS in us-east-2
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}

