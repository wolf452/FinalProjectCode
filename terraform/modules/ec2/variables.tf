variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
}

variable "instance_type" {
  description = "The type of EC2 instance"
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
}

variable "security_group_id" {
  description = "The ID of the security group to assign to the instance"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the instance"
}

variable "cloudwatch_config_ssm_key" {
  description = "The SSM key for CloudWatch agent configuration"
}

variable "key_name" {
  description = "The name of the key pair to use for the EC2 instance"
}
