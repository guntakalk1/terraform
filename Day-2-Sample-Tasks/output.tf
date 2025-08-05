output "instance_id" {
  value = aws_instance.test1.id
}

output "public_ip" {
  value = aws_instance.test1.public_ip
  
}

output "private_ip" {
  value = aws_instance.test2.private_ip
  
}