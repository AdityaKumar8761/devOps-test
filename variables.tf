variable "region" {
  type = string
}



variable "vpc_cidr_block" {
    type = string
}



variable "public_subnet_1_cidr" {
    type = string
}

variable "public_subnet_1_az" {
  type = string
}

variable "public_subnet_2_cidr" {
  type = string
}


variable "public_subnet_2_az" {
  type = string
}




variable "private_subnet_cidr_1" {
  type = string
}

variable "private_subnet_az_1" {
  type=string
}


variable "private_subnet_cidr_2" {
  type = string
}

variable "private_subnet_az_2" {
  type = string
}


variable "sgName" {
  type = string
}
variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}

variable "ec2AvailabilityZone" {
  type = string
}

variable "ebsSize" {
  type = number
}
variable "ebsType" {
  type = string
}

