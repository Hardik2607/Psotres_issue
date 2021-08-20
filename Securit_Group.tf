### Security_Group for RDS Postgres DataBase
module "db_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4"
  name        = "rds_sq"
  description = "Complete PostgreSQL example security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
    Name = "${local.Name}-db-sg"
  }
}


### Security_Group for EKS Worker Nodes
module "worker_mgmt" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4"
  name        = "${local.Name}-worker_mgmt"
  description = "Elastic Kubernetes Service security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Worker nodes access from within VPC"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  tags = {
    Name = "${local.Name}-eks-worker-mgmt"
  }
}


### Security Group for ElasticSearch
module "ES" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4"
  name        = "${local.Name}-es-sg"
  description = "Elastic Kubernetes Service security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "Worker nodes access from within VPC"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
   Name = "${local.common_prefix}-es-sg"
  }
}

resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

resource "aws_security_group" "worker_group_mgmt_two" {
  name_prefix = "worker_group_mgmt_two"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}