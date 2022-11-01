variable "aws_region" {
  description = "AWS region for all resources."
  default     = "ap-southeast-2"
}

variable "bucket_name" {
  description = "AWS backend bucket name"
  default     = "35middle-terraform-state-bucket"
}

variable "table_name" {
  description = "AWS dynamogo db name"
  default     = "35middle-terraform-state-lock-dynamodb"
}


