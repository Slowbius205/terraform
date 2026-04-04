subnet_config = {
  default = {
    cidr_block = "10.0.0.0/24"
  }

  subnet_1 = {
    cidr_block = "10.0.1.0/24"
  }
}

ec2_instance_config_map = {
  ubuntu_1 = {
    instance_type = "t2.micro"
    ami           = "ubuntu"
    # subnet_index  = 0 (default optional value)
  }

  nginx_1 = {
    instance_type = "t2.micro"
    ami           = "nginx"
    subnet_name   = "subnet_1"
  }
}