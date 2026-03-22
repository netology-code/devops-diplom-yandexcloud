# === Аутентификация ===
variable "yandex_cloud_id" {
  type        = string
  description = "ID облака Yandex Cloud"
  sensitive   = true
}

variable "yandex_folder_id" {
  type        = string
  description = "ID папки для ресурсов"
  sensitive   = true
}

variable "yandex_token" {
  type        = string
  description = "IAM-токен для аутентификации"
  sensitive   = true
}

# === Backend ===
variable "bucket_name" {
  type        = string
  description = "Имя bucket для хранения terraform state"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{2,62}[a-z0-9]$", var.bucket_name))
    error_message = "Имя bucket должно соответствовать правилам именования."
  }
}

# === Общие параметры ===
variable "region" {
  type        = string
  description = "Регион развертывания"
  default     = "ru-central1"
}

variable "environment" {
  type        = string
  description = "Окружение: dev/stage/prod"
  default     = "dev"
}

variable "project_name" {
  type        = string
  description = "Имя проекта для префиксов ресурсов"
  default     = "diploma"
}

# === KMS (для шифрования) ===
variable "kms_rotation_period" {
  type        = string
  description = "Период ротации KMS ключа"
  default     = "8760h" # 1 год
}

variable "kms_deletion_protection" {
  type        = bool
  description = "Защита KMS ключа от удаления"
  default     = false
}