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

# === Backend (из bootstrap) ===
variable "tfstate_bucket_name" {
  type        = string
  description = "Имя bucket для хранения state (из bootstrap)"
}

# === Сетевые параметры ===
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

variable "vpc_cidr" {
  type        = string
  description = "CIDR-блок для VPC"
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  type        = list(string)
  description = "Список зон доступности для подсетей"
  # Важно: для регионального Kubernetes мастер нужны минимум 2 зоны
  default     = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
}

# === Экономия ресурсов (требование диплома) ===
variable "use_preemptible" {
  type        = bool
  description = "Использовать прерываемые ВМ для экономии до 80%"
  default     = true
}

variable "minimal_resources" {
  type        = bool
  description = "Минимизировать ресурсы ВМ для экономии бюджета"
  default     = true
}