output "instance_id" {
  value = aws_instance.ec2.id
}

output "ec2_public_ips" {
  value = aws_instance.ec2.public_ip
}

output "ec2_public_ip" {
  value = aws_instance.ec2.public_ip
}
