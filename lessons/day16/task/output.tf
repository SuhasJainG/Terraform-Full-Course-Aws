output "users" {
  value = [for user in local.users: "${user.first_name} ${user.last_name}"]
}

output "acc-id" {
  value = data.aws_caller_identity.name
}
