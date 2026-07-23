variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "devops-lab"
}

variable "project_name" {
  description = "Name prefix used to tag resources"
  type        = string
  default     = "devops-iac-lab"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the public subnet"
  type        = string
  default     = "us-east-1a"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# --- Remote backend reference values (must match the bootstrap outputs) ---
variable "state_bucket_name" {
  description = "S3 bucket name used for remote state (from bootstrap)"
  type        = string
  default     = "devops-lab-tfstate-188776114506"
}

variable "state_lock_table" {
  description = "DynamoDB table used for state locking (from bootstrap)"
  type        = string
  default     = "terraform-locks"
}
