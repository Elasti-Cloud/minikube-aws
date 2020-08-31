profile  = "ENTER-AWS-PROFILE-NAME"
region   = "us-east-2"
admin_ip = "ENTER HOME IP or RANGE cidr - 120.120.120.120/32"

network = {
  vpc_cidr    = "10.130.0.0/16"
  public_cidr = "10.130.0.0/24"
  vpc_az      = "us-east-2b"
}
inst_params = {
  ami      = "ami-01e36b7901e884a10"
  type     = "t3.micro"
  key_name = "minikube"
}

tags = {
  Name        = "Minikube"
  Tool        = "Terraform"
  Environment = "DEV"
}