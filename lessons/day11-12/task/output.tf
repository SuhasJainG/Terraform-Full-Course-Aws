output "projectname" {
  value = local.formatted_project_name
}

output "formatted_ports_final" {
  value = local.formatted_ports_final
}

output "sg_rules" {
  value = local.sg_rules
}

output "allowed_instance_size" {
  value = local.allowed_instance_size
}

output "instance_type" {
  value = var.instance_type
}

output "backup" {
  value = var.backup
  sensitive = true
}

output "all_regions" {
  value = local.all_regions
}

output "positive_cost" {
  value = local.positive_cost
}

output "max_cost" {
  value = local.max_cost
}

output "min_cost" {
  value = local.min_cost
}