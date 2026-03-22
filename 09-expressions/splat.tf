locals {
  firstnames_from_splat        = var.objects_list[*].firstname
  roles_from_splat             = [for username, user_props in local.users_map2 : user_props.roles] # equivalent to below
  roles_from_splat_with_values = values(local.users_map2)[*].roles # equivalent to above
}

output "firstnames_from_splat" {
  value = local.firstnames_from_splat
}

output "roles_from_splat" {
  value = local.roles_from_splat
}