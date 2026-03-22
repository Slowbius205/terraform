locals {
  doubled_numbers = [for n in var.numbers_list : n * 2]
  even_numbers    = [for n in var.numbers_list : n if n % 2 == 0]
  firstnames      = [for person in var.objects_list : person.firstname]
  fullnames       = [for person in var.objects_list : "${person.firstname} ${person.lastname}"]
}

output "double_number" {
  value = local.doubled_numbers
}

output "even_numbers" {
  value = local.even_numbers
}

output "firstnames" {
  value = local.firstnames
}

output "fullnames" {
  value = local.fullnames
}