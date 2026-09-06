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

# 💡 NEW CONFIGURATION: The Remote Backend Block
terraform {
  backend "s3" {
    # The name of the S3 bucket we scaffolded earlier
    bucket         = "srini-tf-revision-state-bucket"

    # The unique file path where this specific folder will store its state file inside the bucket
    key            = "chapters/chapter2/single-server/terraform.tfstate"
    region         = "us-east-2"

    # The DynamoDB table name we scaffolded for distributed file locking
    dynamodb_table = "srini-tf-revision-locks-table"
    encrypt        = true
  }
}

resource "aws_instance" "example" {
  ami           = "ami-0fb653ca2d3203ac1" # Ubuntu 20.04 LTS in us-east-2
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}
i
