variable "aws_region" {
  default = "us-east-1"
}

variable "my_ip" {
  description = "Your IP address with /32"
  default     = "98.216.180.122/32"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for RDS"
}

variable "db_username" {
  description = "Master username"
  default     = "admin"
}

variable "db_password" {
  description = "Master password"
  sensitive   = true
}
