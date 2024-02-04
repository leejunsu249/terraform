##### Default Configuration #####
aws_region = "ap-northeast-2"
aws_shot_region = "an2"
environment = "dev"
service_name = "naemo"
wallet_service_name = "naemo-wallet"
s3_tfstate_file = "comm.tfstate"
aws_account_number = 385866877617

#### cognito #####
centralwallet_cognito_name = "naemo-centralwallet"
systemadmin_cognito_name = "naemo-systemadmin"

#### service #####
ec2_keypair_name = "ec2-key"
bcs_keypair_name = "bcs-key"
wallet_keypair_name = "wallet-key"
test_bc_keypair_name = "test-bc"

#### ec2 ####
common_ami = "ami-00394dd0b14adb2a2" // common ami in an2
bcs_instance_type = "c6i.large"
peer1_instance_type = "c6i.xlarge"

kms = {
  count         = 1,
  instance_type = "c6i.large",
  disk          = 100
  ami           = "ami-0a3c03b9aa7b870a3"
}

#### tuna ####
tuna_ip = "10.0.4.133/32"

#### kms acm ###
kms_acm_arn = "arn:aws:acm:ap-northeast-2:385866877617:certificate/a65155e2-0e23-4f57-baf0-94629a3b0ba0"