#!/bin/bash
yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine -y
yum update -y
yum install yum-utils -y
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum update -y
yum install docker-ce docker-ce-cli containerd.io -y
systemctl enable --now docker
usermod -aG docker centos
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64   && chmod +x minikube
mkdir -p /usr/local/bin/
install minikube /usr/local/bin/
mkdir -p /home/centos/K8
cd /home/centos/K8
yum install git -y
git clone https://github.com/Elasti-Cloud/minikube-aws.git
sudo -u centos bash << EOF
/usr/local/bin/minikube start --driver=docker
cd /home/centos/K8/minikube-aws/K8
kubectl create -f sample-deployment.yaml
kubectl create -f sample-lb-service.yaml
EOF