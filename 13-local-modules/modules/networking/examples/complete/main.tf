module "vpc" {
  source = "./modules/networking"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "13-local-modules"
  }

  subnet_config = {
    subnet_1 = {
      cidr_block = "10.0.0.0/24"
      az         = ("eu-west-1a")
    }
    subnet_2 = {
      cidr_block = "10.0.1.0/24"
      # The "public" key is optional. If not provided, the subnet will be private by default.
      public = true
      az     = ("eu-west-1b")
    }
  }
}