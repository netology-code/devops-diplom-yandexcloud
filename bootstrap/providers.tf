# Провайдер для работы с Yandex Cloud
# Backend НЕ указан — state хранится локально на этом этапе

terraform {
  required_version = ">= 1.6"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.120"
    }
  }
}

provider "yandex" {
  token     = var.yandex_token
  cloud_id  = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
  zone      = "${var.region}-d" # Дефолтная зона для ресурсов
}