# Создаём worker-ы - для управления кластером (отдельные инстансы)
resource "yandex_compute_instance" "k8s_cp" {
  count       = local.k8s[local.workspace].controls.count
  name        = "kube-cp-${count.index+1}"
  platform_id = local.k8s.platform_id
  hostname    = "kube-cp-${count.index+1}"
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

  scheduling_policy {
    preemptible = local.k8s.preemptible
  }

  metadata = {
    user-data = "${file(var.meta_file)}"
#    ssh-keys = "${var.ssh_user}:${file(var.public_key_path)}"
  }

}


# Создаём ноды кластера на котором непосредственно будут запущены приложения (отдельные инстансы без NAT)

resource "yandex_compute_instance" "k8s_node" {
  count       = local.k8s[local.workspace].workers.count
  name        = "kube-node-${count.index+1}"
  platform_id = local.k8s.platform_id
  hostname    = "kube-node-${count.index+1}"
  zone        = local.networks[count.index - floor(count.index / length(local.networks)) * length(local.networks)].zone_name

  resources {
    cores         = local.k8s[local.workspace].workers.cpu
    memory        = local.k8s[local.workspace].workers.memory
    core_fraction = local.k8s[local.workspace].workers.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = local.k8s.image_id
      type     = local.k8s.disk_type
      size     = local.k8s[local.workspace].workers.disk_size
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public[count.index - floor(count.index / length(local.networks)) * length(local.networks)].id
    nat       = false
  }

  scheduling_policy {
    preemptible = local.k8s.preemptible
  }

  metadata = {
    user-data = "${file(var.meta_file)}"
#    ssh-keys = "${var.ssh_user}:${file(var.public_key_path)}"
  }

}

#для настройки кластера можно использовать отдельный хост либо одну из мастер-нод (worker)
