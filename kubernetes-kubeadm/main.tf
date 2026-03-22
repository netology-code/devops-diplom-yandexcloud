data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

locals {
  ssh_public_key = file(var.ssh_public_key_path)
  
  cloud_config = <<-EOF
#cloud-config
users:
  - name: ${var.vm_username}
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh-authorized-keys:
      - ${local.ssh_public_key}
runcmd:
  - apt-get update
  - apt-get install -y curl wget vim git jq
  - echo "Base setup completed on $(hostname)"
EOF
}

# 🎯 Мастер-нода (НЕ прерываемая!)
resource "yandex_compute_instance" "master" {
  name        = "${var.project_name}-k8s-master"
  hostname    = "${var.project_name}-k8s-master"
  zone        = var.yandex_zone
  description = "Kubernetes master node"

  resources {
    cores         = var.master_resources.cores
    memory        = var.master_resources.memory
    core_fraction = var.master_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.master_resources.disk_size
      type     = var.master_resources.disk_type
    }
  }

  network_interface {
    subnet_id          = var.subnet_id
    security_group_ids = [var.security_group_id]
    nat                = true
  }

  metadata = {
    user-data  = local.cloud_config
    ssh-keys   = "${var.vm_username}:${local.ssh_public_key}"
  }

  scheduling_policy {
    preemptible = false  # Мастер НЕ должен прерываться
  }

  labels = {
    role        = "master"
    environment = var.environment
  }
}

# 👷 Рабочие ноды (МОГУТ быть прерываемыми)
resource "yandex_compute_instance" "worker" {
  count       = var.worker_count
  name        = "${var.project_name}-k8s-worker-${count.index + 1}"
  hostname    = "${var.project_name}-k8s-worker-${count.index + 1}"
  zone        = var.yandex_zone
  description = "Kubernetes worker node"

  resources {
    cores         = var.worker_resources.cores
    memory        = var.worker_resources.memory
    core_fraction = var.worker_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.worker_resources.disk_size
      type     = var.worker_resources.disk_type
    }
  }

  network_interface {
    subnet_id          = var.subnet_id
    security_group_ids = [var.security_group_id]
    nat                = true
  }

  metadata = {
    user-data  = local.cloud_config
    ssh-keys   = "${var.vm_username}:${local.ssh_public_key}"
  }

  scheduling_policy {
    preemptible = var.use_preemptible  # Рабочие МОГУТ прерываться
  }

  labels = {
    role        = "worker"
    environment = var.environment
  }
}