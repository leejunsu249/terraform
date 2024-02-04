aws_region = "ap-northeast-2"
aws_shot_region = "an2"
environment = "net"
service_name = "naemo"
account_id = "351894368755"

domain = "mgmt.an2.net.naemo.io"

vpc_cidr = "10.0.16.0/24"

azs = ["ap-northeast-2a", "ap-northeast-2c"]


egress_public_subnets = ["10.0.16.0/27", "10.0.16.32/27"]
egress_protected_nfw_subnets = ["10.0.16.64/27", "10.0.16.96/27"]
egress_private_inner_subnets = ["10.0.16.128/27", "10.0.16.160/27"]


fivetuple_stateful_rule_group = []
domain_stateful_rule_group = []
suricata_stateful_rule_group = []
stateless_rule_group = []
stateless_default_actions = "forward_to_sfe"
stateless_fragment_default_actions = "forward_to_sfe"