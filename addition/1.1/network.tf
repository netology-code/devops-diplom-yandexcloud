# Создаем VPC
resource "yandex_vpc_network" "vpc" {
  name = "${local.name[local.workspace]}-vpc"
}

#Создаем подсети на основе переменных locals
resource "yandex_vpc_subnet" "public" {
  count          = length(local.networks)
  v4_cidr_blocks = local.networks[count.index].subnet
  zone           = local.networks[count.index].zone_name
  network_id     = yandex_vpc_network.vpc.id
  name           = "${local.networks[count.index].name}-subnet"
}
