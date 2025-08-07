terraform {
  backend "s3" {
    bucket       = "kiranuniquebukcet-123456789"
    key            = "Day-4-Statelocking/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt = true  
    
  }
}