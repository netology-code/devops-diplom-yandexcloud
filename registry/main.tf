# ============================================================
# 🗄️ Yandex Container Registry для тестового приложения
# ============================================================

resource "yandex_container_registry" "diploma" {
  name      = var.registry_name
  folder_id = var.yandex_folder_id
  
  labels = {
    project     = "diploma"
    environment = "dev"
    managed_by  = "terraform"
  }
}

# 🔐 IAM: права на pull для узлов кластера
#resource "yandex_container_registry_iam_binding" "diploma_puller" {
#  registry_id = yandex_container_registry.diploma.id
#  role        = "container-registry.images.puller"
#  
#  members = [
#    "serviceAccount:${var.k8s_node_service_account_id}",
#  ]
#}

# 🔐 IAM: права на push для управления
#resource "yandex_container_registry_iam_binding" "diploma_pusher" {
#  registry_id = yandex_container_registry.diploma.id
#  role        = "container-registry.images.pusher"
#  
#  members = [
#    "serviceAccount:${var.k8s_service_account_id}",
#  ]
#}