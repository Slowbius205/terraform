variable "subnet_config" {
  type = map(object({
    cidr_block = string
  }))

# Ensure that all provided CIDR blocks are valid
  validation {
    condition = alltrue([
      # can is a hashicorp function that evaluates the given expression and returns a boolean value indicating whether the expression produced a result without any errors
      # cidrnetmask is a hashicorp function that converts an IPv4 address prefix given in CIDR notation into a subnet mask address
      for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))
    ])
    error_message = "At least one of the provided CIDR blocks is not valid."
  }
}

variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami           = string
    subnet_name   = optional(string, "default")
  }))

  default = []

  # Ensure that only t2.micro is used (all 3 points done in one expression)
  # 1. DONE Map from the object to the instance_type
  # 2. DONE Map from the instance_type to a boolean indicating whether the value equals t2.micro
  # 3. DONE Check whether the list of booleans contains only true values

  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["t2.micro"], config.instance_type)
    ])
    error_message = "Only t2.micro instances are allowed."
  }

  # Ensure that only ubuntu and nginx images are used
  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["nginx", "ubuntu"], config.ami)
    ])
    error_message = "At least one of the provided \"ami\" values is not supported.\nSupported \"ami\" values: \"ubuntu\", and \"nginx\"."
  }
}
variable "ec2_instance_config_map" {
  type = map(object({
    instance_type = string
    ami           = string
    subnet_name   = optional(string, "default")
  }))

  validation {
    condition = alltrue([
      # syntax below is identical to syntax on line 55
      for key, config in var.ec2_instance_config_map : contains(["t2.micro"], config.instance_type)
    ])
    error_message = "Only t2.micro instances are allowed."
  }

  # Ensure that only ubuntu and nginx images are used
  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["nginx", "ubuntu"], config.ami)
    ])
    error_message = "At least one of the provided \"ami\" values is not supported.\nSupported \"ami\" values: \"ubuntu\", and \"nginx\"."
  }
}