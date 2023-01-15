#Текущий Workspace
output "workspace"{
  value = terraform.workspace
}

#данные созданных инстансов

output "k8s_control_plane" {
  value = yandex_compute_instance.k8s_cp.*.network_interface.0.nat_ip_address
}

output "k8s_control_plane_IP" {
  value = yandex_compute_instance.k8s_cp.*.network_interface.0.ip_address
}

