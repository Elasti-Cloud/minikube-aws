# Main configuration
terraform {
  required_version = ">=0.13"
}
# AWS Provider 
provider "aws" {
  version = ">=3.0"
  profile = var.profile
  region  = var.region
}

# ////////////////////////////////////////////
# VPC, Subnet, IGW, RT
resource "aws_vpc" "vpc" {
  cidr_block           = var.network["vpc_cidr"]
  enable_dns_hostnames = true
  tags                 = var.tags
}
# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.tags
}
# Public subnet
resource "aws_subnet" "sn_public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.network["public_cidr"]
  availability_zone       = var.network["vpc_az"]
  map_public_ip_on_launch = true
  tags                    = var.tags
}
# Public routing table
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = var.tags
}
resource "aws_route_table_association" "rt_pub_subnets" {
  subnet_id      = aws_subnet.sn_public.id
  route_table_id = aws_route_table.rt_public.id
}
# //////////////////////////
# Security Group for EC2
resource "aws_security_group" "sg_minikube" {
  name   = "minikube"
  vpc_id = aws_vpc.vpc.id
  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}
# ////////////////////////////////////////
# EC2 instance for the Minikube
resource "aws_spot_instance_request" "minikube" {
  ami                    = var.inst_params["ami"]
  instance_type          = var.inst_params["type"]
  key_name               = var.inst_params["key_name"]
  subnet_id              = aws_subnet.sn_public.id
  vpc_security_group_ids = [aws_security_group.sg_minikube.id]
  tags                   = var.tags
  # spot request parameters
  spot_price = "0.03"
  spot_type  = "one-time"

  # User Data for the CentOS 7
  user_data = filebase64("./bootstrap.sh")

}
