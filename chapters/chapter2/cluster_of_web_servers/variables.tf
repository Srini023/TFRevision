variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
  default     = "terraform-asg-example"
}

