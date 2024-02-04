# resource "aws_route53_record" "private_orderer1_record" {
#   zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
#   name    = "orderer1.${data.terraform_remote_state.network.outputs.domain_name}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.orderer1.private_ip]
# }

# resource "aws_route53_record" "private_orderer2_record" {
#   zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
#   name    = "orderer2.${data.terraform_remote_state.network.outputs.domain_name}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.orderer1.private_ip]
# }

# resource "aws_route53_record" "private_orderer3_record" {
#   zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
#   name    = "orderer3.${data.terraform_remote_state.network.outputs.domain_name}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.orderer1.private_ip]
# }

# resource "aws_route53_record" "private_peer1_bm1_record" {
#   zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
#   name    = "peer1.bm1.${data.terraform_remote_state.network.outputs.domain_name}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.peer1.private_ip]
# }

# resource "aws_route53_record" "private_peer2_bm1_record" {
#   zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
#   name    = "peer2.bm1.${data.terraform_remote_state.network.outputs.domain_name}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.peer1.private_ip]
# }

# resource "aws_route53_record" "private_peer1_bm2_record" {
#   zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
#   name    = "peer1.bm2.${data.terraform_remote_state.network.outputs.domain_name}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.peer1.private_ip]
# }

# resource "aws_route53_record" "private_peer2_bm2_record" {
#   zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
#   name    = "peer2.bm2.${data.terraform_remote_state.network.outputs.domain_name}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.peer1.private_ip]
# }

# resource "aws_route53_record" "private_monarest_record" {
#   zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
#   name    = "mona-rest.${data.terraform_remote_state.network.outputs.domain_name}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.monarest.private_ip]
# }

# resource "aws_route53_record" "private_monascan_record" {
#   zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
#   name    = "monascan.${data.terraform_remote_state.network.outputs.domain_name}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.monascan.private_ip]
# }

# resource "aws_route53_record" "private_monamgr_record" {
#   zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
#   name    = "mona-mgr.${data.terraform_remote_state.network.outputs.domain_name}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.monamgr.private_ip]
# }

resource "aws_route53_record" "private_solana_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "solana.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.solana.private_ip]
}

# resource "aws_route53_record" "private_orderer_record" {
#   zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
#   name    = "orderer.${data.terraform_remote_state.network.outputs.domain_name}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.orderer1.private_ip]
# }

# resource "aws_route53_record" "private_peer_record" {
#   zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
#   name    = "peer.${data.terraform_remote_state.network.outputs.domain_name}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.peer1.private_ip]
# }

resource "aws_route53_record" "private_publistener_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "pub-listener.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.publistner.private_ip]
}

resource "aws_route53_record" "private_ethereum_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "ethereum.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.ethereum.private_ip]
}
