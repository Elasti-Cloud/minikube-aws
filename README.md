# Deploying Minikube on an AWS instance with Terraform

### For the convinience, it is a ready-to-use deployment. However, most parameters can be adjusted. The purpose is to quickly deploy a Minikube standalone node for the learning purposes.
### Please refer to the official documentation in case you want to use Ubuntu or newer releases: [Install Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)  
### Provisioned infrastructure will result in costs

## Prerequisites:
* An AWS account and a user with a porgrammatic access;
* A key-pair in the *us-east-2*;
* Terraform < 0.12;
* All variables that require values are in the __terraform.tfvars__ file;

## The repository includes:
* Terraform files for the infrastructure deployment and Minikube configuration:
    * VPC in the *us-east-2* with a public subnet and other required services (IGW, RT etc.);
    * EC2 *m5.large* spot instance in the *us-east-2*;
    * bootstrap.sh with the installation commands that will be aplied to an instance;

## Instruction
* Clone a repository;
* Work through prerequisites;
* Deploy with Terraform;
* Wait for ~10 min (m5.large) then ssh to the created instance;
* run *minikube status* to check that it was installed and started;

### Notes
* to cereate an AWS profile run *aws configure --profile chosen-profile-name* and enter credentials;