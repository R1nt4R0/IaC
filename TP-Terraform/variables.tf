variable "instance_type" {
  description = "Type de l'instance EC2"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Nom de l'instance EC2"
  type        = string
  default     = "nginx-instance"
}

variable "bucket_name" {
  description = "Nom du bucket S3"
  type        = string
  default     = "my-bucket"
}

variable "web_port" {
  description = "Port autorisé dans le security group"
  type        = number
  default     = 80
}