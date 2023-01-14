provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.yc_cloud_id
  folder_id                = var.yc_folder_id
  zone                     = var.yc_zone
}

data "yandex_compute_image" "centos" {
  family = "centos-stream-8"
}

locals {
  vm_image_map = {
    stage = data.yandex_compute_image.centos.id
    prod  = data.yandex_compute_image.centos.id
  }

  vm_count = {
    stage = 3
    prod  = 3
  }
  instance_count ={
    stage =1
    prod =2
  }
  instance_for_each_map = {
    stage = toset(["st1"])
    prod  = toset(["pr1", "pr2"])
  }
}


resource "yandex_compute_instance" "vm_count" {
  count     = local.vm_count[terraform.workspace]
  name      = "${var.vm_prefix}-${count.index}-${terraform.workspace}"
  folder_id = var.yc_folder_id
  zone      = var.yc_zone
  hostname  = "${var.vm_prefix}-${count.index}-${terraform.workspace}"

  resources {
    cores         = var.cores_cnt[terraform.workspace]
    memory        = var.memory_cnt[terraform.workspace]
    core_fraction = var.core_fraction[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = local.vm_image_map[terraform.workspace]
      type     = "network-hdd"
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.vpcsubnet.id
    nat       = true
    ipv6      = false
  }

  metadata = {
    ssh-keys = "${var.login}:${file("~/.ssh/id_rsa.pub")}"
  }


}



resource "yandex_compute_instance" "vm_for_each" {
  for_each = var.project
  #[terraform.workspace]
  #for_each = toset([for o in range(0, var.project.instance_count) : tostring(o+1)])
  #[terraform.workspace]
  #for_each = toset([for o in range(0, local.instance_count[terraform.workspace]) : tostring(o+1)])
  name        = "${var.vm_prefix}-${each.value.environment}"
  hostname    = "${var.vm_prefix}-${each.key}.local"
  platform_id = "standard-v1"

  resources {
    cores         = each.value.cores
    memory        = each.value.memory_size
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = local.vm_image_map[terraform.workspace]
      type     = each.value.hdd_type
      size     = each.value.hdd_size
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.vpcsubnet.id
    nat       = true
    ipv6      = false
  }

  metadata = {
    ssh-keys = "${var.login}:${file("~/.ssh/id_rsa.pub")}"
  }
}
