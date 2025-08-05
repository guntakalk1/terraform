resource "aws_instance" "test1" {
  instance_type = "t2.nano"
  ami = "ami-08a6efd148b1f7504"  # Replace with a valid AMI ID
  tags = {
    Name = "devtest" 
  }
}

resource "aws_instance" "test2" {
  instance_type = var.instance_type
  ami = var.ami_id
  tags = {
    Name = "devtest2"
  }
  
}

resource "aws_instance" "test3" {
  instance_type = var.instance_type
  ami = var.ami_id
  tags = {
    Name = "devtest3"
  }
  
}