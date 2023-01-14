output "internal_ip_address_count" {
  value = yandex_compute_instance.vm_count.*.network_interface.0.ip_address
}

output "external_ip_address_count" {
  value = yandex_compute_instance.vm_count.*.network_interface.0.nat_ip_address
}


output "internal_ip_address_each" {
  value = toset([
    for instance in yandex_compute_instance.vm_for_each : instance.network_interface.0.ip_address
  ])
}

output "external_ip_address_each" {
  value = toset([
    for instance in yandex_compute_instance.vm_for_each : instance.network_interface.0.nat_ip_address
  ])
}