# Default Configuration
aws_region      = "ap-northeast-2"
aws_shot_region = "an2"
environment     = "shd"
service_name    = "naemo"

gitlab_repository_instance_type    = "m6i.xlarge"
gitlab_repository_ami              = "ami-049c6c68b824efd77" // gitlab installed ami
gitlab_bc_repository_instance_type = "r6i.large"
gitlab_bc_repository_ami           = "ami-0ecb6b3c39ec371ca" // gitlab ami
gitlab_keypair_name                = "gitlab-key"

sonarqube_instance_type = "c6i.large"
sonarqube_ami           = "ami-04448bef9f23bb47e" // sonarqube installed ami
sonarqube_keypair_name  = "sonarqube-key"

dbsafer_instance_type = "m6i.xlarge"
dbsafer_ami           = "ami-065ceba4bc59a9862"

hiware_instance_type = "r6i.large"
hiware_ami           = "ami-093157706c74bf19f"

eks_working_instance_type = "t3.micro"
nexus_instance_type = "c6i.large"

common_ami = "ami-090ff466d501ba075" // common
common_os_ami = "ami-07a2c764f2aa59baa" // common os only

ec2_keypair_name = "ec2-key"

dev_account = { "number" = "385866877617", "role" = "dev-gitlab-role" }
stg_account = { "number" = "087942668956", "role" = "stg-gitlab-role" }
prd_account = { "number" = "908317417455", "role" = "prd-gitlab-role" }
net_account = { "number" = "351894368755", "role" = "net-gitlab-role" }
