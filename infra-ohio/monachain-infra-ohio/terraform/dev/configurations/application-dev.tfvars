##### Default Configuration #####
aws_region = "us-east-2"
aws_shot_region = "ue2"
environment = "dev"
service_name = "naemo"

##### TEMP Configuration #######
exception_ip_list_remote = [ //remote working user
                    "61.74.89.84/32", "49.174.151.228/32", "125.177.232.71/32", 
                    "112.145.203.205/32", "118.221.81.12/32", "220.85.201.38/32", 
                    "112.155.55.113/32", "222.108.254.238/32", "221.146.54.91/32",
                    "222.109.231.85/32"
                    ] 
exception_ip_list_lgcns = [
                    "165.243.5.20/32",
                    "27.122.140.10/32"
                    ] 
exception_ip_list_thales = [
                    "182.209.81.227/32" 
                    ] 

# key.tf
monachain_keypair_name = "monachain-keypair"

# monachain.tf
default_ami = "ami-06efeec6a29f55668"
monachain_instance_type = "c6i.xlarge"
