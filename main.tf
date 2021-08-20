terraform {
     /* backend "s3" {
      bucket = "fastrax-tfstate"  ### .tfstate file will be stored in Remorte Backend S3 Bucket
      key    = "tfstatefile/terraform.tfstate"
      region = "us-east-2"
      dynamodb_table = "tfstate_lock"
      encrypt = true
      profile = "default"
    }  */
  required_version = "~> 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.53.0"
    }
    kuberenetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.4.0"
    }
  }
}

provider "aws" {
  profile = "hardik"
  region  = var.REGION
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = "false"  
}

data "aws_availability_zones" "az" {
  state = "available"
}
