variable "region" {
  description = "The AWS region to deploy to"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store Terraform state"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table for state locking"
}

variable "vpc_name" {
  description = "The name of the VPC"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
}

variable "subnets" {
  description = "List of subnets to create"
  type = list(object({
    cidr                 = string
    availability_zone    = string
    map_public_ip_on_launch = bool
  }))
}

variable "security_group_rules" {
  description = "List of security group rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "ami_id" {
  description = "The AMI ID to use for EC2 instances"
}

variable "instance_type" {
  description = "The type of EC2 instance"
}

variable "ec2_name" {
  description = "The name of the EC2 instance"
}

variable "cloudwatch_log_group" {
  description = "The CloudWatch log group name"
}

variable "cloudwatch_log_stream" {
  description = "The CloudWatch log stream name"
}

variable "cloudwatch_config_ssm_key" {
  description = "The SSM key for CloudWatch agent configuration"
}

variable "key_name" {
  description = "The name of the key pair to use for EC2 instances"
}
