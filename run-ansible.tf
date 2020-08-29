# Run Ansible playbook install_nginx.yml on web servers

resource "null_resource" "ansible_playbook_run_vm1" {
  depends_on = [local_file.inventory]
  provisioner "remote-exec" {

    connection {
      type        = "ssh"
      user        = "dobriza"
      private_key = file("./ops23")
      host        = google_compute_instance.web_private_1.network_interface[0].access_config[0].nat_ip
    }
  }
  provisioner "local-exec" {
    command = "export ANSIBLE_CONFIG=./ansible.cfg && time ansible-playbook -c paramiko install_nginx.yml -vv"
  }
}

resource "null_resource" "ansible_playbook_run_vm2" {
  depends_on = [null_resource.ansible_playbook_run_vm1]
  provisioner "remote-exec" {

    connection {
      type        = "ssh"
      user        = "dobriza"
      private_key = file("./ops23")
      host        = google_compute_instance.web_private_2.network_interface[0].access_config[0].nat_ip
    }
  }
  provisioner "local-exec" {
    command = "export ANSIBLE_CONFIG=./ansible.cfg && time ansible-playbook -c paramiko install_nginx.yml -vv"
  }
}
