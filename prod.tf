provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

resource "aws_s3_bucket" "prod_tf_course" {
  bucket = "tf-course-rianoc"
  acl    = "private"
}

resource "aws_default_vpc" "default" {}

resource "aws_default_subnet" "default_az1" {
  availability_zone= "eu-west-1a"
    tags = {
    "Terraform" : "true"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone= "eu-west-1b"
    tags = {
    "Terraform" : "true"
  }
}

resource "aws_security_group" "prod-web" {
  name        = "prod-web"
  description = "Allow http/https inbound. Everything outbound"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Terraform" : "true"
  }
}

resource "aws_elb" "prod-web" {
  name            = "prod-web"
  subnets         = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
  security_groups = [aws_security_group.prod-web.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  
  tags = {
    "Terraform" : "true"
  }
}

resource "aws_launch_template" "prod-web" {
  name_prefix   = "prod-web"
  image_id      = "ami-00de9f83a77a54bf1"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "prod-web" {
  #availability_zones = ["eu-west-1a", "eu-west-1b"] In course but causes error
  vpc_zone_identifier = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.prod-web.id
    version = "$Latest"
  }
  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = "true"
  }
}
resource "aws_autoscaling_attachment" "prod-web" {
  autoscaling_group_name = aws_autoscaling_group.prod-web.id
  elb                    = aws_elb.prod-web.id
}