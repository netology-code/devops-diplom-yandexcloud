variable "yandex_cloud_id" {
  type        = string
  sensitive   = true
}

variable "yandex_folder_id" {
  type        = string
  sensitive   = true
}

variable "yandex_key_file" {
  type    = string
  default = "../kubernetes-kubeadm/terraform-sa-key.json"
}

variable "yandex_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "registry_name" {
  type    = string
  default = "diploma-container-registry"
}

# ❌ УДАЛИТЕ или закомментируйте этот блок:
# variable "registry_description" {
#   type    = string
#   default = "Container registry for diploma project test application"
# }

# === Service accounts из kubernetes этапа ===
variable "k8s_service_account_id" {
  type      = string
  sensitive = true
}

variable "k8s_node_service_account_id" {
  type      = string
  sensitive = true
}