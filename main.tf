# gh repo create hands-on-lab-create-ec2-s3-via-terraform-and-github-actions-oidc --public --source=. --remote=upstream

provider "aws" {
  region = "us-east-1"

}

terraform {
  backend "s3" {
    bucket  = "ikram-tests-ko324lsdfjg435"
    key     = "001/terraform.tfstate"
    region  = "us-east-1"
    profile = "pgmbm"
  }
}

resource "aws_default_vpc" "default" {}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "test-ec2" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "test-ec2"
  }
}

output "latest_amazon_linux_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}
