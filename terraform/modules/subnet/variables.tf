variable "vpc_id" {}
variable "subnets" {
  type = list(object({
    cidr                 = string
    availability_zone    = string
    map_public_ip_on_launch = bool
  }))
}
