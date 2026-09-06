variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique."
  type        = string
  default     = "srini-tf-revision-state-bucket"
}

variable "table_name" {
  description = "The name of the DynamoDB table for state locking"
  type        = string
  default     = "srini-tf-revision-locks-table"
}

