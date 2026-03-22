# ============================================================
# 📤 ВЫХОДНЫЕ ЗНАЧЕНИЯ для следующих этапов
# ============================================================

output "vpc_id" {
  description = "ID созданной VPC сети"
  value       = yandex_vpc_network.main.id
}

output "vpc_name" {
  description = "Имя VPC сети"
  value       = yandex_vpc_network.main.name
}

output "subnet_ids" {
  description = "Список ID подсетей по зонам доступности"
  value       = { for az, subnet in yandex_vpc_subnet.main : az => subnet.id }
}

output "security_group_id" {
  description = "ID security group для Kubernetes узлов"
  value       = yandex_vpc_security_group.k8s_nodes.id
}

output "network_cidr" {
  description = "CIDR-блок основной сети"
  value       = var.vpc_cidr
}

# 📋 Сводка для диплома
output "infrastructure_summary" {
  description = "Краткая сводка созданной инфраструктуры"
  value = <<SUMMARY
✅ Сетевая инфраструктура создана:

• VPC: ${yandex_vpc_network.main.name}
• Подсети: ${length(yandex_vpc_subnet.main)} шт. в зонах: ${join(", ", var.availability_zones)}
• Security Group: ${yandex_vpc_security_group.k8s_nodes.name}
• NAT включён: да (для исходящего трафика)
• Экономия: прерываемые ВМ = ${var.use_preemptible ? "включено" : "выключено"}

Следующий шаг: создание Managed Kubernetes кластера.
SUMMARY
}