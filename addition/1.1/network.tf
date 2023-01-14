resource "yandex_vpc_network" "vpcnet" {
  name = "vpcnet"
}

resource "yandex_vpc_subnet" "vpcsubnet" {
  name           = "vpcsubnet"
  network_id     = resource.yandex_vpc_network.vpcnet.id
  v4_cidr_blocks = ["10.2.0.0/24"]
  zone           = "ru-central1-a"
}
