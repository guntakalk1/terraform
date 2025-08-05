variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = ""  # Replace with a valid AMI ID      
  
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance"
  type        = string
  default     = ""  # Default instance type
  
}