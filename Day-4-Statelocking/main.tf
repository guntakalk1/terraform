resource "aws_instance" "test" {
    ami = var.ami_id
    instance_type = var.instance_typee
    key_name = var.key_name
   # region = var.region
    tags = {
        name = "prod_test"

    }
    }
  
  resource "aws_s3_bucket" "bucketdetails" {
    bucket = var.bucketname
    acl    = "private"
    tags = { 
        name = "prd_bucket"     
    }
  }

  resource "aws_s3_bucket_object" "objectadd" {
    bucket = aws_s3_bucket.bucketdetails.bucket
    key    = "example.txt"
    content = "This is an example file."    
  }
