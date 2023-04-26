resource "ncloud_vpc" "nvpc" {
    name = "kubernetes-vpc"
    ipv4_cidr_block = "10.0.0.0/16"
}

resource "ncloud_subnet" "k8s-cluster-kr1" {
  vpc_no         = ncloud_vpc.nvpc.id
  subnet         = "10.0.11.0/24"
  zone           = "KR-1"
  network_acl_no = ncloud_vpc.nvpc.default_network_acl_no
  subnet_type    = "PRIVATE"
  name           = "k8s-cluster-kr1"
}

resource "ncloud_subnet" "k8s-lb-kr1" {
  vpc_no         = ncloud_vpc.nvpc.id
  subnet         = "10.0.12.0/24"
  zone           = "KR-1"
  network_acl_no = ncloud_vpc.nvpc.default_network_acl_no
  subnet_type    = "PRIVATE"
  usage_type     = "LOADB"
  name           = "k8s-lb-kr1"
}