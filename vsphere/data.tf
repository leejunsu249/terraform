
output "master_ip" {
  value = vsphere_virtual_machine.vm-master.*.default_ip_address
}

output "node_ip" {
  value = vsphere_virtual_machine.vm-node-manager.*.default_ip_address
}

output "master_ip_member" {
  value = vsphere_virtual_machine.vm-master-member.*.default_ip_address
}

output "node_ip_member" {
  value = vsphere_virtual_machine.vm-node-member.*.default_ip_address
}

# resource "time_sleep" "wait_50s" {
#   count = var.multi_cluster ? 0 : 1
#   depends_on = [vsphere_virtual_machine.vm-master,vsphere_virtual_machine.vm-node-manager]
#   create_duration = "60s"
# }

# resource "time_sleep" "multi_wait_60s" {
#   count = var.multi_cluster ? 1 : 0
#   depends_on = [vsphere_virtual_machine.vm-master,vsphere_virtual_machine.vm-master-member,vsphere_virtual_machine.vm-node-manager,vsphere_virtual_machine.vm-node-member]
#   create_duration = "60s"
# }

resource "local_file" "hosts" {
    count    = var.only_node ? 0 : 1
    content  = templatefile(
                    "${path.module}/templates/hosts.tmpl",
                    {
                        master_ip = vsphere_virtual_machine.vm-master.*.default_ip_address,
                        node_ip  = vsphere_virtual_machine.vm-node-manager.*.default_ip_address,
                        master_ip_member = vsphere_virtual_machine.vm-master-member.*.default_ip_address,
                        node_ip_member = vsphere_virtual_machine.vm-node-member.*.default_ip_address,
                        single_option  = var.single_option,
                        add_master     = var.add_master
                    }
            )
    filename = "${var.install_path}hosts"
}

resource "local_file" "host_yaml" {
    count    = var.only_node ? 0 : 1
    content  = templatefile(
                    "${path.module}/templates/host.tmpl",
                    {
                        master_ip = vsphere_virtual_machine.vm-master.*.default_ip_address,
                        node_ip  = vsphere_virtual_machine.vm-node-manager.*.default_ip_address,
                        guest_id = var.os[var.case].vsphere_guestid,
                        single_option     = var.single_option,
                        podman_cidr       = var.network_setting[var.case].podman_cidr,
                        pod_network_cidr  = var.network_setting[var.case].pod_network_cidr,
                        calico_ippool     = var.network_setting[var.case].calico_ippool,
                        interface_cidr    = var.network_setting[var.case].interface_cidr,
                        service_cidr      = var.service_cidr,
                        proxy_mode        = var.network_setting[var.case].proxy_mode,
                        calico_autodetection_mode = var.network_setting[var.case].calico_autodetection_mode,
                        calico_backend    = var.network_setting[var.case].calico_backend,
                        registry_domain_option    = var.network_setting[var.case].registry_domain_option,
                        kubelet_clusterdns        = var.kubelet_clusterdns,
                        kubernetes_clusterip      = var.kubernetes_clusterip, 
                        nas                       = var.nas
                    }
            )
    filename = "${var.install_path}group_vars/host.yml"
}

resource "local_file" "member_yaml" {
    count    = var.multi_cluster ? 1 : 0 
    content  = templatefile(
                    "${path.module}/templates/member.tmpl",
                    {
                        master_ip_member = vsphere_virtual_machine.vm-master-member.*.default_ip_address,
                        node_ip_member = vsphere_virtual_machine.vm-node-member.*.default_ip_address,
                        guest_id = var.os[var.case].vsphere_guestid,
                        nas               = var.nas
                    }
            )
    filename = "${var.install_path}group_vars/member.yml"
}



