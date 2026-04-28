module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_1_az = var.public_subnet_1_az
  public_subnet_2_cidr= var.public_subnet_2_cidr
  public_subnet_2_az = var.public_subnet_2_az
  private_subnet_cidr_1= var.private_subnet_cidr_1
  private_subnet_az_1= var.private_subnet_az_1
  private_subnet_cidr_2= var.private_subnet_cidr_2
  private_subnet_az_2= var.private_subnet_az_2
}

module "ec2" {
  source = "./modules/ec2"

  sgName = var.sgName
  ami  = var.ami
  instance_type = var.instance_type
  ec2AvailabilityZone = var.ec2AvailabilityZone
  ebsSize = var.ebsSize
  ebsType  = var.ebsType
  vpc_id = module.vpc.vpc_id
  private_subnet_id1 = module.vpc.private_subnet_id1
}


module "alb" {
  source = "./modules/alb"
  security_group_id = module.ec2.sg
  public_subnet_id1 = module.vpc.public_subnet_id1
  public_subnet_id2 = module.vpc.public_subnet_id2
  vpc_id = module.vpc.vpc_id
  ec2_instance_id = module.ec2.ec2Instance
}