resource "ncloud_nat_gateway" "nat_gateway" {
  vpc_no      = ncloud_vpc.nvpc.id
  zone        = "KR-1"
  // below fields is optional
  name        = "k8s-nat-gw"
  description = "This is NAT GW for kubernetes cluster."
}