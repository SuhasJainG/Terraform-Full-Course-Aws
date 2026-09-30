locals {
  formatted_project_name = lower(replace(var.projectname," ","-"))

  formatted_tags = merge(var.default_tags,var.environment_tags)

  formatted_bucket_name = lower(replace(replace(substr(var.bucket_name,0,63)," ","-"),"!",""))

  formatted_ports = split(",",var.allowed_ports)
  sg_rules = [for port in local.formatted_ports: {
    name = "port-${port}"
    port = port
    description = "Allow traffic on port ${port}"
  }
  ]
  formatted_ports_final = join("-", [for port in local.formatted_ports : "port-${port}"])

  allowed_instance_size = lookup(var.instance_sizes, var.environment, "t2.micro")

  all_regions = toset(concat(var.user_locations,var.default_locations))

  positive_cost = [for cost in var.monthly_costs: abs(cost)]

  max_cost = max(local.positive_cost...)
  min_cost = min(local.positive_cost...)
}
