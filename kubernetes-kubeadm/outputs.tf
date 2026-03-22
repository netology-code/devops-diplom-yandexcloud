output "master_external_ip" {
  value = yandex_compute_instance.master.network_interface[0].nat_ip_address
}

output "master_internal_ip" {
  value = yandex_compute_instance.master.network_interface[0].ip_address
}

output "worker_external_ips" {
  value = [for w in yandex_compute_instance.worker : w.network_interface[0].nat_ip_address]
}

output "worker_internal_ips" {
  value = [for w in yandex_compute_instance.worker : w.network_interface[0].ip_address]
}

output "ansible_inventory" {
  value = <<-EOF
[master]
${yandex_compute_instance.master.network_interface[0].nat_ip_address} ansible_user=${var.vm_username}

[workers]
%{ for ip in [for w in yandex_compute_instance.worker : w.network_interface[0].nat_ip_address] ~}
${ip} ansible_user=${var.vm_username}
%{ endfor ~}

[all:children]
master
workers

[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
ansible_python_interpreter=/usr/bin/python3
EOF
}

output "ssh_commands" {
  value = {
    master  = "ssh ${var.vm_username}@${yandex_compute_instance.master.network_interface[0].nat_ip_address}"
    workers = [
      for i, w in yandex_compute_instance.worker :
      "ssh ${var.vm_username}@${w.network_interface[0].nat_ip_address}  # worker-${i + 1}"
    ]
  }
}