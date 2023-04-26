resource "vsphere_virtual_machine" "vm-master" {
  count            = "${var.vsphere_vmcount}"
  name             = "${var.vsphere_vmname}${count.index+1}-${var.vsphere_ipstart + count.index}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_cluster_id     = data.vsphere_datastore_cluster.datastore_cluster.id
  num_cpus         = data.vsphere_virtual_machine.vm_template.num_cpus
  memory           = data.vsphere_virtual_machine.vm_template.memory
  guest_id         = var.os[var.case].vsphere_guestid
  scsi_type        = data.vsphere_virtual_machine.vm_template.scsi_type
  firmware         = data.vsphere_virtual_machine.vm_template.firmware


  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.vm_template.disks.0.size
    eagerly_scrub    = false
    thin_provisioned = var.os[var.case].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.vm_template.id
    linked_clone  = "true"

    customize {

      linux_options {
        host_name = "acc-master${count.index+1}"
        domain    = ""
      }

      network_interface {
        ipv4_address = "${var.vsphere_ip}${var.vsphere_ipstart + count.index}"
        ipv4_netmask = var.vsphere_ipv4_netmask
      }
      dns_server_list = [var.vsphere_dns_server1]
      ipv4_gateway = var.vsphere_ipv4_gateway

    }
 }

  provisioner "remote-exec" {
    inline = ["hostnamectl set-hostname acc-master${count.index+1}"]
    connection {
      type     = "ssh"
      user     = var.host_id
      password = var.host_pass
      host     = "${var.vsphere_ip}${var.vsphere_ipstart + count.index}"
    }
  }

}

resource "vsphere_virtual_machine" "vm-master-member" {
  count            = var.multi_cluster ? var.vsphere_vmcount : 0
  name             = "${var.vsphere_vmname}${count.index+1}-${var.vsphere_ipstart_member + count.index}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_cluster_id     = data.vsphere_datastore_cluster.datastore_cluster.id
  num_cpus         = data.vsphere_virtual_machine.vm_template.num_cpus
  memory           = data.vsphere_virtual_machine.vm_template.memory
  guest_id         = var.os[var.case].vsphere_guestid
  scsi_type        = data.vsphere_virtual_machine.vm_template.scsi_type
  firmware         = data.vsphere_virtual_machine.vm_template.firmware


  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.vm_template.disks.0.size
    eagerly_scrub    = false
    thin_provisioned = var.os[var.case].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.vm_template.id
    linked_clone  = "true"

    customize {

      linux_options {
        host_name = "acc-master${count.index+1}"
        domain    = ""
      }

      network_interface {
        ipv4_address = "${var.vsphere_ip}${var.vsphere_ipstart_member + count.index}"
        ipv4_netmask = var.vsphere_ipv4_netmask
      }
      dns_server_list = [var.vsphere_dns_server1]
      ipv4_gateway = var.vsphere_ipv4_gateway
    }
 }
  provisioner "remote-exec" {
    inline = ["hostnamectl set-hostname acc-master${count.index+1}"]
    connection {
      type     = "ssh"
      user     = var.host_id
      password = var.host_pass
      host     = "${var.vsphere_ip}${var.vsphere_ipstart_member + count.index}"
    }
  }
}