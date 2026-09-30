output "primary_vpc_id" {
  description = "ID of the primary VPC"
  value       = aws_vpc.primary-vpc.id
}

output "secondary_vpc_id" {
  description = "ID of the secondary VPC"
  value       = aws_vpc.secondary-vpc.id
}

output "vpc_peering_connection_id" {
  description = "ID of the VPC peering connection"
  value       = aws_vpc_peering_connection.primary-to-secondary.id
}

output "primary_instance_id" {
  description = "ID of the primary EC2 instance"
  value       = aws_instance.primary_instance.id
}

output "secondary_instance_id" {
  description = "ID of the secondary EC2 instance"
  value       = aws_instance.secondary_instance.id
}

output "primary_instance_public_ip" {
  description = "Public IP of the primary EC2 instance"
  value       = aws_instance.primary_instance.public_ip
}

output "secondary_instance_public_ip" {
  description = "Public IP of the secondary EC2 instance"
  value       = aws_instance.secondary_instance.public_ip
}
