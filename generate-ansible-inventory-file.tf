# Create host.ini file for Ansible

resource "local_file" "inventory" {
  filename = "hosts.ini"
  content  = <<-EOT

[web]
${aws_route53_record.web1.name}.${data.aws_route53_zone.devops.name}
${aws_route53_record.web2.name}.${data.aws_route53_zone.devops.name}

[web:vars]
ansible_user = dobriza
ansible_ssh_private_key_file = ./ops23
  EOT
}
