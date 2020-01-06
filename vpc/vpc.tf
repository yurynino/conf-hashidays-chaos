provider "aws" {
  region = "us-west-2"
  access_key="CHANGEME"
  secret_key = "CHANGEME"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "gremlin_vpc"

  cidr = "10.10.0.0/16"

  azs           	= ["us-west-2a"]
  public_subnets	= ["10.10.1.0/24"]

  tags = {
	Owner   	= "yyninor"
	Environment = "chaos"
  }
}

module "security_group" {
  source = "terraform-aws-modules/security-group/aws"
  name    	= "ssh"
  description = "ssh from anywhere"
  vpc_id  	= "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules   	= ["ssh-tcp","all-icmp"]
  egress_rules    	= ["all-all"]
}
