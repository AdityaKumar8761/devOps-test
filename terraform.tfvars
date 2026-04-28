region = "sa-east-1"

vpc_cidr_block = "10.0.0.0/16"




public_subnet_1_cidr = "10.0.1.0/24"
public_subnet_1_az = "sa-east-1a"

public_subnet_2_cidr = "10.0.2.0/24"
public_subnet_2_az = "sa-east-1b"

private_subnet_cidr_1 = "10.0.101.0/24"
private_subnet_az_1 = "sa-east-1a"

private_subnet_cidr_2 = "10.0.102.0/24"
private_subnet_az_2 = "sa-east-1b"



sgName = "terraform-sg"
ami = "ami-046979544cd9e3d7b"
instance_type = "t3.micro"



ec2AvailabilityZone = "sa-east-1a"






ebsSize = 8
ebsType = "gp2"
