#############################################################
# for ROCKY8
#############################################################
# resource "null_resource" "rocky8-setting" {
#   count = var.case == 2 ? 1 : 0
#   depends_on = [ local_file.hosts, local_file.host_yaml ]
#   provisioner "remote-exec" {
#     inline = [
#         "ansible-playbook -i ${var.install_path}hosts ~/ssh-key.yml",
#         "ansible-playbook -i ${var.install_path}hosts ~/rocky8.yml"
#         ]
#   }

#   connection {
#       type     = "ssh"
#       user     = var.host_id
#       password = var.host_pass
#       host     = var.host_ip
#     }
# }

#############################################################
# install accordion
#############################################################
resource "null_resource" "ssh-keygen" {
  count = var.multi_cluster ? 0 : var.add_node ? 0 : var.add_member ? 0 : 1
  depends_on = [ local_file.hosts, local_file.host_yaml ]
  provisioner "remote-exec" {
    inline = [ 
        "ansible-playbook -i ${var.install_path}hosts ~/ssh-key.yml",
        "ansible-playbook -i ${var.install_path}hosts ${var.install_path}all.yml"
        ]
  }

  connection {
      type     = "ssh"
      user     = var.host_id
      password = var.host_pass
      host     = var.host_ip
    }
}

resource "null_resource" "ssh-keygen-multi" {
  count = var.multi_cluster ? var.add_member_node ? 0 : var.add_member ? 0 : 1 : 0
  depends_on = [ local_file.hosts, local_file.host_yaml, local_file.member_yaml]
  provisioner "remote-exec" {
    inline = [ 
        "ansible-playbook -i ${var.install_path}hosts ~/ssh-key.yml",
        "ansible-playbook -i ${var.install_path}hosts ${var.install_path}all.yml"
        ]
  }

  connection {
      type     = "ssh"
      user     = var.host_id
      password = var.host_pass
      host     = var.host_ip
    }
}

#############################################################
# add node
#############################################################

resource "null_resource" "add-node" {
  count = var.add_node ? var.only_node ? 0 : 1 : 0
  depends_on = [ local_file.hosts, local_file.host_yaml ]
  provisioner "remote-exec" {
    inline = [ 
        "ansible-playbook -i ${var.install_path}hosts ~/ssh-key.yml",
        "ansible-playbook -i ${var.install_path}hosts ${var.install_path}node.yml -e 'TARGET='acc-host-node${length(vsphere_virtual_machine.vm-node-manager.*.default_ip_address)}"
        ]
  }

  connection {
      type     = "ssh"
      user     = var.host_id
      password = var.host_pass
      host     = var.host_ip
    }
}

resource "null_resource" "add-member-node" {
  count = var.multi_cluster ? var.add_member_node ? 1 : 0 : 0
  depends_on = [ local_file.hosts, local_file.member_yaml ]
  provisioner "remote-exec" {
    inline = [ 
        "ansible-playbook -i ${var.install_path}hosts ~/ssh-key.yml",
        "ansible-playbook -i ${var.install_path}hosts ${var.install_path}node.yml -e 'TARGET='acc-member-node${length(vsphere_virtual_machine.vm-node-member.*.default_ip_address)}"
        ]
  }

  connection {
      type     = "ssh"
      user     = var.host_id
      password = var.host_pass
      host     = var.host_ip
    }
}

#############################################################
# add member
#############################################################
resource "null_resource" "add-member-cluster" {
  count = var.multi_cluster ? var.add_member ? 1 : 0 : 0
  depends_on = [ local_file.hosts, local_file.member_yaml ]
  provisioner "remote-exec" {
    inline = [ 
        "ansible-playbook -i ${var.install_path}hosts ~/ssh-key.yml",
        "ansible-playbook -i ${var.install_path}hosts ${var.install_path}addmember.yml"
        ]
  }

  connection {
      type     = "ssh"
      user     = var.host_id
      password = var.host_pass
      host     = var.host_ip
    }
}

#############################################################
# add master
#############################################################
resource "null_resource" "add-master-cluster" {
  count = var.add_master ? 1 : 0
  depends_on = [ local_file.hosts, local_file.host_yaml ]
  provisioner "remote-exec" {
    inline = [ 
        "ansible-playbook -i ${var.install_path}hosts ~/ssh-key.yml",
        "ansible-playbook -i ${var.install_path}hosts ${var.install_path}master.yml -e 'TARGET=manager'"
        ]
  }
  
  connection {
      type     = "ssh"
      user     = var.host_id
      password = var.host_pass
      host     = var.host_ip
    }
}