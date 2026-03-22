# ============================================================
# 🔄 Провайдер + Backend для основной инфраструктуры
# Backend указывает на bucket из bootstrap этапа
# ============================================================

terraform {
  required_version = ">= 1.6"
  
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.120"
    }
  }
  
  # 🗄️ Backend: S3 bucket в Yandex Object Storage
  backend "s3" {
    # Эти значения можно передать через -backend-config или оставить как переменные
    # При инициализации: terraform init -backend-config="bucket=..." и т.д.
    
    endpoint = "https://storage.yandexcloud.net"  # ✅ Правильный формат
    region   = "ru-central1"
    key      = "terraform/infrastructure.tfstate"
    
    # 🔧 Обход валидаций для Yandex Cloud
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  token     = var.yandex_token
  cloud_id  = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
  zone      = "${var.region}-d"
}