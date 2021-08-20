
variable "aws-profile" {
  type = string
  description = "Use the Profile to your AWS Account"
  //default = ""
}
variable "REGION" {
  description = "Region in which infrastructure will get Deployed"
  default     = "us-east-2"
}

variable "es_version" {
  description = "Elastic Search Version"
  default     = "7.10"
}

variable "vpc_cidr" {
  description = "CIDR Block for private cloud"
  default     = "10.16.0.0/16"
}
variable "public_subnet_cidrs" {
  description = "Public CIDR"
  default     = ["10.16.48.0/20", "10.16.112.0/20", "10.16.176.0/20"]
}
variable "private_subnet_cidrs" {
  description = "Private CIDR"
  default     = ["10.16.16.0/20", "10.16.32.0/20", "10.16.80.0/20", "10.16.96.0/20", "10.16.144.0/20", "10.16.160.0/20"]
}

////////////////////////// ES Variables //////////////////////////////


variable "es_instance_type" {
  type        = string
  default     = "t3.medium.elasticsearch"
  description = "Elasticsearch instance type for data nodes in the cluster"
}

variable "es_instance_count" {
  type        = number
  description = "Number of data nodes in the cluster"
  default     = 3
}

variable "es_ebs_volume_size" {
  type        = number
  description = "EBS volumes for data storage in GB"
  default     = 20
}

variable "es_ebs_volume_type" {
  type        = string
  default     = "gp2"
  description = "Storage type of EBS volumes"
}
////////////////////////// EKS Variables //////////////////////////////
variable "eks_ebs_volume_size" {
  type        = number
  description = "EBS volumes for data storage in GB"
  default     = 20
}
variable "eks_instance_type" {
  type        = string
  default     = "t2.medium"
  description = "Worker nodes instance type for data nodes in the cluster"
}
////////////////////////// RDS Variables //////////////////////////////

variable "rds_instance_class" {
  type        = string
  description = "Instance class type for DB"
  default     = "db.t3.micro"
}

variable "rds_port" {
  type        = number
  description = "RDS Port"
  default     = "5432"
}

variable "rds_engine" {
  type        = string
  description = "RDS Engine"
  default     = "postgres"
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::941517746288:role/eksclusterrole"
      username = "admin"
      groups   = ["system:masters"]
    },
  ]
} 

 variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::941517746288:user/admin"
      username = "admin"
      groups   = ["system:masters"]
    },
    ]
}
variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = [
    "941517746288",
  ]
}