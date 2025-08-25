variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-0de716d6197524dd9"
  
}

variable "bucket_name" {
    description = "The name of the S3 bucket"
    type = string
    default = "kirans3uniquebucket"
}

variable "instance" {
    description = "An example AWS instance"
    type = string
    default = "t2.nano"
}
