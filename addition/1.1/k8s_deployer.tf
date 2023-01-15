# Создаём дополнительный инстанс для настройки кластера из ЯО
resource "yandex_compute_instance" "k8s_deployer" {
  count       = 1
  name        = "deployer"
  platform_id = local.k8s.platform_id
  hostname    = "deployer"
  zone        = local.networks[count.index - floor(count.index / length(local.networks)) * length(local.networks)].zone_name

  resources {
    cores         = local.k8s[local.workspace].controls.cpu
    memory        = local.k8s[local.workspace].controls.memory
    core_fraction = local.k8s[local.workspace].controls.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = local.k8s.image_id
      type     = local.k8s.disk_type
      size     = local.k8s[local.workspace].controls.disk_size
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public[count.index - floor(count.index / length(local.networks)) * length(local.networks)].id
    nat       = true
  }

//поскольку данный хост необходим только на время настройки то мы можем пренебречь его доступностью в будущем.
  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data = "${file(var.meta_file)}"
#    ssh-keys = "${var.ssh_user}:${file(var.public_key_path)}"
  }

}

output "k8s_deployer_nat_IP" {
  value = yandex_compute_instance.k8s_deployer.*.network_interface.0.nat_ip_address
}

output "k8s_deployer_IP" {
  value = yandex_compute_instance.k8s_deployer.*.network_interface.0.ip_address
}

