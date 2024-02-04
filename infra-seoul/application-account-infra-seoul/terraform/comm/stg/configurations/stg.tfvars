##### Default Configuration #####
aws_region         = "ap-northeast-2"
aws_shot_region    = "an2"
environment        = "stg"
service_name       = "naemo"
wallet_service_name = "naemo-wallet"
s3_tfstate_file    = "comm.tfstate"
aws_account_number = 087942668956
azs                = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]

#### cognito #####
centralwallet_cognito_name = "naemo-centralwallet"
systemadmin_cognito_name = "naemo-systemadmin"

#### service #####
ec2_keypair_name = "ec2-key"
bcs_keypair_name = "bcs-key"
wallet_keypair_name = "wallet-key"

#### ec2 ####
common_ami = "ami-090ff466d501ba075" // common ami in an2

orderer = {
  count         = 3,
  instance_type = "c6i.large",
  disk          = 300
}

peer = {
  count         = 4,
  instance_type = "c6i.large",
  disk          = 300
}

monarest = {
  count         = 4,
  instance_type = "c6i.large",
  disk          = 100
}

monamgr = {
  count         = 1,
  instance_type = "c6i.large",
  disk          = 100
}

kms = {
  count         = 2,
  instance_type = "c6i.xlarge",
  disk          = 100
}

#### tuna ####
tuna_ip = "10.0.7.88/32"