# Create ansible.cfg file

resource "local_file" "ansible_config" {
  filename = "ansible.cfg"
  content  = <<-EOT
[defaults]
inventory = ./hosts.ini
host_key_checking = False
retry_files_enabled = True
 EOT
}
