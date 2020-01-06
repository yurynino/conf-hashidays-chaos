provider "aws" {
  region = "us-west-2"
  access_key="CHANGEME"
  secret_key = "CHANGEME"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
	name = "name"
	values = [ "amzn-ami-hvm-*-x86_64-gp2", ]
  }

  filter {
	name = "owner-alias"
	values = [ "amazon" ]
  }
}

module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"
  instance_count = 1

  name                    	= "gremlin-instance"
  ami                     	= "${data.aws_ami.amazon_linux.id}"
  associate_public_ip_address = true
  instance_type           	= "t2.micro"
  subnet_id               	= "subnet-014294c2a4eacdfa4"
  vpc_security_group_ids  	= ["sg-0d0cca7429ed38855"]
  key_name                	= "gremlin-key"
  user_data               	= "${file("userdata.sh")}"

  tags = {
	Owner   	= "adl"
	Environment = "chaos"
	DeployFrom  = "terraform"
  }
}