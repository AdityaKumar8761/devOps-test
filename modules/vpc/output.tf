output "vpc_id" {
  value = aws_vpc.terraform_vpc.id
}

output "public_subnet_id1" {
  value = aws_subnet.public_subnet_terraform1.id
}

output "public_subnet_id2" {
  value = aws_subnet.public_subnet_terraform2.id
}

output "private_subnet_id1" {
  value = aws_subnet.private_subnet_terraform1.id
}

output "private_subnet_id2" {
  value = aws_subnet.private_subnet_terraform2.id
}