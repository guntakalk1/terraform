variable "ami_id" {
  description = "AMI ID for the AWS instance"
  type        = string
  default = "ami-084a7d336e816906b"
  
}

variable "instance_typee" {
    description = "Instance type for the AWS instance"
    type = string
    default = "t2.micro"
}

variable "region" {
    description = "AWS region for the instance"
    type = string
    default = "us-east-1"
}

variable "bucketname" {
    description = "Name of the S3 bucket"
    type = string
    default = "kiranuniquebukcet-123456789"  # Ensure this is globally unique
}

variable "key_name" {
    description = "Name of the key pair for SSH access"
    type = string
    default = "testkeypair"  # Replace with your actual key pair name
}