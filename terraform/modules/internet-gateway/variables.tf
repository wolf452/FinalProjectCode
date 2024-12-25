variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "subnets" {
  description = "List of subnets to associate with the route table"
  type = list(object({
    cidr      = string
    subnet_id = string
  }))
}
