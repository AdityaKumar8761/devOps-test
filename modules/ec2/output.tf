output "ec2Instance" {
  value = aws_instance.ec2.id
}

output "sg" {
  value = aws_security_group.security_group.id
}