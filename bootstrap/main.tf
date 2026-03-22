# ============================================================
# 🎯 ЦЕЛЬ: Создать минимальный набор ресурсов для работы Terraform
# ============================================================

# 🎭 Сервисный аккаунт для управления инфраструктурой
# ⚠️ Внимание: yandex_iam_service_account НЕ поддерживает tags/labels
resource "yandex_iam_service_account" "terraform" {
  folder_id   = var.yandex_folder_id
  name        = "${var.project_name}-${var.environment}-terraform-sa"
  description = "Service account for Terraform infrastructure automation"
}

# 🔐 Назначение роли "editor" сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "terraform_editor" {
  folder_id = var.yandex_folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.terraform.id}"
}

# 🔑 Статический ключ доступа для S3 Object Storage
resource "yandex_iam_service_account_static_access_key" "terraform_s3_key" {
  service_account_id = yandex_iam_service_account.terraform.id
  description        = "Static access key for S3 backend storage"
}

# 🔐 KMS ключ для шифрования bucket (как в вашем рабочем примере)
resource "yandex_kms_symmetric_key" "tfstate_key" {
  name                = "${var.project_name}-${var.environment}-tfstate-key"
  description         = "KMS key for terraform state encryption"
  default_algorithm   = "AES_128"
  rotation_period     = "8760h" # 1 год
  deletion_protection = false
}

# 🪣 Bucket для хранения terraform state
resource "yandex_storage_bucket" "tfstate" {
  bucket        = var.bucket_name
  folder_id     = var.yandex_folder_id # ✅ Обязательно для корректного биллинга
  force_destroy = false

  # ⚠️ acl deprecated, но пока работает. Для продакшена использовать yandex_storage_bucket_grant
  acl = "private"

  # 🔒 Шифрование с использованием KMS (как в вашем рабочем примере)
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.tfstate_key.id
        sse_algorithm     = "aws:kms" # ✅ Единственное допустимое значение
      }
    }
  }

  # 🌐 Разрешаем публичный доступ на чтение (опционально, для отладки)
  anonymous_access_flags {
    read = false # ❌ false для приватного state-файла
    list = false
  }

  # 🗑️ Политика жизненного цикла
  lifecycle_rule {
    id      = "cleanup_old_state_versions"
    enabled = true

    noncurrent_version_expiration {
      days = 30
    }
  }

  # 🌐 CORS конфигурация (внутри ресурса, как требует провайдер)
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3600
  }
}