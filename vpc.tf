module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name = "${local.Name}-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.az.names
  private_subnets = var.private_subnet_cidrs
  public_subnets  = var.public_subnet_cidrs

  private_subnet_tags = {
    Tier = "Private"
  }
  public_subnet_tags = {
    Tier = "Public"
  }
  single_nat_gateway     = true
  enable_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true

}

//resource "aws_route53_zone" "private" {
//  name = var.private_domain
//
//  vpc {
//    vpc_id = module.vpc.vpc_id
//  }
//}


// vpc module url
// https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.44.0
