provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "OMDatacenter3"
}

data "vsphere_datastore_cluster" "datastore_cluster" {
  name          = "DataStoreCluster"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "Cluster"
  datacenter_id = data.vsphere_datacenter.dc.id
}


data "vsphere_network" "network" {
  name          = "VM-MGMT-10.60.x"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "vm_template" {
  name          = var.os[var.case].vsphere_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

# data "vsphere_virtual_machine" "vm_template_node" {
#   name          = var.vsphere_template_node
#   datacenter_id = data.vsphere_datacenter.dc.id
# }

