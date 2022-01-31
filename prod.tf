provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

resource "aws_s3_bucket" "prod_tf_course" {
  bucket = "tf-course-rianoc"
  acl    = "private"
}

resource "aws_default_vpc" "default" {}