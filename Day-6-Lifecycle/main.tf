


resource "aws_instance" "test" {
    ami  = var.ami_id
    instance_type = var.instance
}


resource "aws_s3_bucket" "s3bucket" {
    bucket = var.bucket_name
    lifecycle {
        prevent_destroy = true
    }
}