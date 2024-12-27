provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  name   = var.vpc_name
  cidr   = var.vpc_cidr
}

module "subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
  subnets = var.subnets
}

module "internet_gateway" {
  source = "./modules/internet-gateway"
  vpc_id = module.vpc.vpc_id
  subnets = [
    for idx in range(length(var.subnets)) : {
      cidr      = var.subnets[idx].cidr
      subnet_id = module.subnet.public_subnet_ids[idx]
    }
  ]
}

module "security_group" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
  security_group_rules = var.security_group_rules
}

module "ec2_instance" {
  source            = "./modules/ec2"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.subnet.public_subnet_ids[0]
  security_group_id = module.security_group.security_group_id
  tags = {
    Name = var.ec2_name
  }
  cloudwatch_config_ssm_key = var.cloudwatch_config_ssm_key
  key_name                  = var.key_name
}

module "cloudwatch" {
  source          = "./modules/cloudwatch"
  log_group_name  = var.cloudwatch_log_group
  log_stream_name = var.cloudwatch_log_stream
  cloudwatch_config_ssm_key = var.cloudwatch_config_ssm_key
}

resource "local_file" "ansible_inventory" {
  content = <<-EOT
    [slave]
    ${module.ec2_instance.public_ip} ansible_ssh_user=ubuntu 
  EOT
  filename = "../ansible/inventory"
}
