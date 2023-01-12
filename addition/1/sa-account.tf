// Создание сервисного аккаунта
resource "yandex_iam_service_account" "sa" {
    name      = "sa-terraform"
}

// Выдаём права
#viewer — позволяет только просматривать информацию о ресурсах.
#editor — позволяет управлять ресурсами (создавать и изменять их).
#admin — позволяет управлять доступом к ресурсам и самими ресурсами (создавать, изменять и удалять их).
#yc iam role list - список всех ролей, выбрать подходящую


// Назначение роли сервисному аккаунту
#resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
#  folder_id = var.yc_folder_id
#  role      = "storage.editor"
#  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
#}


resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
    folder_id = var.yc_folder_id
    role      = "editor"
    member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
    depends_on = [yandex_iam_service_account.sa]
}


// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}


resource "yandex_iam_service_account_key" "sa-auth-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "auth key for terraform"
  key_algorithm      = "RSA_2048"
}


// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "netology" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "ingvar78"
}