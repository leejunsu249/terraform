# Default Configuration
aws_region = "us-east-2"
aws_shot_region = "ue2"
environment = "shd"
service_name = "naemo"

cluster_exception_ip_list = ["124.49.193.195/32", "165.243.5.20/32", "27.122.140.10/32", "115.139.141.70/32"] 

gitlab_repository_instance_type = "c5.xlarge"
gitlab_repository_ami = "ami-06efeec6a29f55668" // gitlab installed ami
gitlab_bc_repository_instance_type = "r6i.large"
gitlab_bc_repository_ami = "ami-061ba55d0a6401835" // gitlab ami
gitlab_keypair_name = "gitlab-key"

sonarqube_instance_type = "c5.large"
sonarqube_ami = "ami-02614a02cd8accb95" // sonarqube installed ami
sonarqube_keypair_name = "sonarqube-key"

ec2_keypair_name = "ec2-key"

coderay_instance_type = "t3.2xlarge"
coderay_ami = "ami-06efeec6a29f55668" // ami-ue2-shd-common 
coderay_keypair_name = "coderay-key"

dev_account = { "number" = "385866877617", "role" = "dev-gitlab-role"}
stg_account = { "number" = "087942668956", "role" = "stg-gitlab-role"}
prd_account = { "number" = "908317417455", "role" = "prd-gitlab-role"}
net_account = { "number" = "351894368755", "role" = "net-gitlab-role"}
