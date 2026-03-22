locals {
  name = "Neil Walker"
  age  = 30
  my_object = {
    key1 = 10
    key2 = "my_value"
  }
}

output "example1" {
  value = startswith(lower(local.name), "john")
}

output "example2" {
  value = pow(local.age, 2)
}

output "example3" {
  # value = file("${path.module}/users.yaml")
  value = yamldecode(file("${path.module}/users.yaml")).users[*].name # parses a string as a subset of YAML, and produces a representation of its value. Or using splat syntax: .users[*].name
}

output "example4" {
  #value = yamlencode(local.my_object) # output as a yaml object
  value = jsonencode(local.my_object) # output as a json object
}