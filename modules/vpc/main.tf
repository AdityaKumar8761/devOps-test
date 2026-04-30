resource "aws_vpc" "terraform_vpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "vpc"
  }
}


//puclic subnet --1

resource "aws_subnet" "public_subnet_terraform1" {
  vpc_id = aws_vpc.terraform_vpc.id
  cidr_block = var.public_subnet_1_cidr
  availability_zone = var.public_subnet_1_az
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

resource "aws_route_table" "public_rt1" {
    vpc_id = aws_vpc.terraform_vpc.id
}

resource "aws_route" "public_internet1" {
  route_table_id = aws_route_table.public_rt1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc1" {
  subnet_id = aws_subnet.public_subnet_terraform1.id
  route_table_id = aws_route_table.public_rt1.id
}


//puclic subnet --2

resource "aws_subnet" "public_subnet_terraform2" {
  vpc_id = aws_vpc.terraform_vpc.id
  cidr_block = var.public_subnet_2_cidr
  availability_zone = var.public_subnet_2_az
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

resource "aws_route_table" "public_rt2" {
    vpc_id = aws_vpc.terraform_vpc.id
}

resource "aws_route" "public_internet2" {
  route_table_id = aws_route_table.public_rt2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc2" {
  subnet_id = aws_subnet.public_subnet_terraform2.id
  route_table_id = aws_route_table.public_rt2.id
}






resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "terraform-igw"
  }
}


//private 1



resource "aws_subnet" "private_subnet_terraform1" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = var.private_subnet_cidr_1
  availability_zone = var.private_subnet_az_1
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet"
  }
}

resource "aws_eip" "nat_eip1" {
    domain = "vpc"
}

resource "aws_nat_gateway" "gw_Nat1" {
  allocation_id = aws_eip.nat_eip1.id
  subnet_id     = aws_subnet.public_subnet_terraform1.id

  tags = {
    Name = "gw-NAT1"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private_rt1" {
  vpc_id = aws_vpc.terraform_vpc.id
}

resource "aws_route" "private_internet" {
  route_table_id = aws_route_table.private_rt1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.gw_Nat1.id
}

resource "aws_route_table_association" "private_associate" {
    subnet_id = aws_subnet.private_subnet_terraform1.id
    route_table_id = aws_route_table.private_rt1.id
}



//private 2



resource "aws_subnet" "private_subnet_terraform2" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = var.private_subnet_cidr_2
  availability_zone = var.private_subnet_az_2
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet"
  }
}

resource "aws_eip" "nat_eip2" {
    domain = "vpc"
}

resource "aws_nat_gateway" "gw_Nat2" {
  allocation_id = aws_eip.nat_eip2.id
  subnet_id     = aws_subnet.public_subnet_terraform2.id

  tags = {
    Name = "gw-NAT1"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private_rt2" {
  vpc_id = aws_vpc.terraform_vpc.id
}

resource "aws_route" "private_internet2" {
  route_table_id = aws_route_table.private_rt2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.gw_Nat2.id
}

resource "aws_route_table_association" "private_associate2" {
    subnet_id = aws_subnet.private_subnet_terraform2.id
    route_table_id = aws_route_table.private_rt2.id
}