/*
Two ways to remove resources
1. Remove via the CLI
2. Remove via the removed block
*/

removed {
  from = aws_s3_bucket.my_new_bucket

  lifecycle {
    destroy = false
  }
}

# resource "aws_s3_bucket" "my_new_bucket" {
#   bucket = "random-bucket-name-1234vsdxc"
# }