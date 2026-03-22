output "registry_id" {
  description = "ID созданного реестра"
  value       = yandex_container_registry.diploma.id
}

output "registry_name" {
  description = "Имя реестра"
  value       = yandex_container_registry.diploma.name
}

output "registry_endpoint" {
  description = "Endpoint для docker login"
  value       = "cr.yandex"
}

output "image_name_template" {
  description = "Шаблон имени образа для push"
  value       = "cr.yandex/${yandex_container_registry.diploma.id}/diploma-test-app:TAG"
}

output "docker_login_command" {
  description = "Команда для авторизации в реестре"
  value       = "yc container registry configure --id ${yandex_container_registry.diploma.id}"
}