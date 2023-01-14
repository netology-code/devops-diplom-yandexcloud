provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.yc_cloud_id
  folder_id                = var.yc_folder_id
  zone                     = var.yc_zone
}


resource "yandex_iam_service_account" "this" {
  name        = var.sa_name
  description = var.sa_description
  folder_id = var.yc_folder_id
}

resource "yandex_resourcemanager_folder_iam_binding" "this" {
  for_each = var.sa_roles
  folder_id = var.yc_folder_id
  role = each.key
  members = [
    "serviceAccount:${yandex_iam_service_account.this.id}",
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "sa-folder-binding" {
  for_each = local.folder_bindings
  folder_id = each.value.folder
  role = each.value.role
  members = [
    "serviceAccount:${yandex_iam_service_account.this.id}",
  ]
}

resource "yandex_resourcemanager_cloud_iam_binding" "sa-cloud-binding" {
  for_each = local.cloud_bindings
  cloud_id = each.value.cloud
  role = each.value.role
  members = [
    "serviceAccount:${yandex_iam_service_account.this.id}",
  ]
}

resource "yandex_iam_service_account_api_key" "sa-api-key" {
  service_account_id = yandex_iam_service_account.this.id
  description        = "api key for authorization"
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.this.id
  description        = "static access key for object storage"
}

resource "yandex_iam_service_account_key" "sa-auth-key" {
  service_account_id = yandex_iam_service_account.this.id
  description        = "json key for service account"
}


// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "netology" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = var.bucket_tf
}