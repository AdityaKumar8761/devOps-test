resource "aws_security_group" "security_group" {
  name   = var.sgName
  vpc_id = var.vpc_id

  tags = {
    Name = "terraform security group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingressPorts" {
  security_group_id = aws_security_group.security_group.id
  from_port         = 8080
  ip_protocol        = "tcp"
  to_port           = 8080
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  associate_public_ip_address = true
  availability_zone = var.ec2AvailabilityZone
  root_block_device {
    delete_on_termination = true
    volume_size = var.ebsSize
    volume_type = var.ebsType
  }

  vpc_security_group_ids = [aws_security_group.security_group.id]
  subnet_id       = var.private_subnet_id1


  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y apache2

              # Change Apache port to 8080
              sed -i 's/80/8080/g' /etc/apache2/ports.conf
              sed -i 's/:80/:8080/g' /etc/apache2/sites-available/000-default.conf

              systemctl restart apache2
              systemctl enable apache2

              echo "<h1>Server is working via ALB</h1>" > /var/www/html/index.html
              EOF

              //Sir this part ^^^ is something i copy and pasted from gpt

  tags = {
    Name = "ClassTest"
  }
}