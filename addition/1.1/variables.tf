variable "yc_cloud_id" {
  description = "Cloud"
}
variable "yc_folder_id" {
  description = "Folder"
}
variable "yc_zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}

variable "yc_image_family" {
  default = "centos-8"
}

variable "vm_prefix" {
  default = "centos"
}

variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable "service_account_key_file" {
  description = "key .json"
}
variable "private_key_path" {
  description = "Path to Private Key File"
}

variable "sa_id" {
  description = "SERVICE ACCOUNT ID"
}

variable "login" {
  default = "centos"
}
#count
variable "cores_cnt" {
  default = {
    prod  = 4
    stage = 2
  }
}

variable "memory_cnt" {
  default = {
    prod  = 4
    stage = 2
  }
}
variable "core_fraction" {
  default = {
    prod  = 100
    stage = 20
  }
}

# For_each
variable "project" {
  description = "Map of project names to configuration"
  type        = map(any)
  default = {
    stage = {
      core_fraction = 20
      memory_size   = 1
      cores         = 2
      hdd_type      = "network-hdd"
      hdd_size      = 15
      environment   = "stage"
      instance_count         = 1
    },
    prod = {
      core_fraction = 20
      memory_size   = 2
      cores         = 4
      hdd_type      = "network-ssd"
      hdd_size      = 25
      environment   = "prod"
      instance_count         = 2
    }
  }
}
