variable "yandex_cloud_id" {
  type        = string
  sensitive   = true
}

variable "yandex_folder_id" {
  type        = string
  sensitive   = true
}

variable "yandex_key_file" {
  type        = string
  default     = "terraform-sa-key.json"
}

variable "vpc_network_id" {
  type    = string
  default = "enpkueaodh8kh3117nnt"
}

variable "subnet_id" {
  type    = string
  default = "e9bc8gll7ocj29uv1ve6"
}

variable "security_group_id" {
  type    = string
  default = "enp8ktl4ok6a48g49uht"
}

variable "yandex_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "project_name" {
  type    = string
  default = "diploma"
}

variable "vm_username" {
  type    = string
  default = "yc-user"
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}

variable "master_resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
    disk_size     = number
    disk_type     = string
  })
  default = {
    cores         = 2
    memory        = 4
    core_fraction = 20
    disk_size     = 20
    disk_type     = "network-hdd"
  }
}

variable "worker_resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
    disk_size     = number
    disk_type     = string
  })
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
    disk_size     = 20
    disk_type     = "network-hdd"
  }
}

variable "worker_count" {
  type    = number
  default = 2
}

variable "use_preemptible" {
  type    = bool
  default = true
}

variable "k8s_version" {
  type    = string
  default = "1.28"
}

variable "pod_network_cidr" {
  type    = string
  default = "10.244.0.0/16"
}