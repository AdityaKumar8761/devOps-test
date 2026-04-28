output "albDNS" {
  value = module.alb.albDNS
}







output "ec2Instance" {
  value = module.ec2.ec2Instance
}

output "sg" {
  value = module.ec2.sg
}






output "vpc_di" {
     value = module.vpc.vpc_id
}
output "pub_subnet_id1" {
  value = module.vpc.public_subnet_id1
}
output "pub_subnet_id2" {
  value = module.vpc.public_subnet_id2
}   
output "piv_sub_id1" {
  value = module.vpc.private_subnet_id1
}
output "piv_sub_id2" {
  value = module.vpc.private_subnet_id2
}