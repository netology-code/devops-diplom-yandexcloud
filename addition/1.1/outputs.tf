#Текущий Workspace
output "workspace"{
  value = terraform.workspace
}

#данные созданных инстансов

output "k8s_cp_nat_IP" {
  value = yandex_compute_instance.k8s_cp.*.network_interface.0.nat_ip_address
}

output "k8s_cp_IP" {
  value = yandex_compute_instance.k8s_cp.*.network_interface.0.ip_address
}

# worker node не имеют внешних IP адресов
output "k8s_node_IP" {
  value = yandex_compute_instance.k8s_node.*.network_interface.0.ip_address
}

