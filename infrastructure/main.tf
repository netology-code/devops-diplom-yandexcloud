# ============================================================
# 🌐 VPC NETWORK — базовая сетевая инфраструктура
# ============================================================

# Основная сеть проекта
resource "yandex_vpc_network" "main" {
  name        = "${var.project_name}-${var.environment}-network"
  description = "Main VPC network for ${var.project_name} (${var.environment})"
  folder_id   = var.yandex_folder_id
}

# 🔀 Таблица маршрутизации для доступа в интернет (NAT через интернет-шлюз)
resource "yandex_vpc_route_table" "main" {
  name       = "${var.project_name}-${var.environment}-route-table"
  network_id = yandex_vpc_network.main.id
  folder_id  = var.yandex_folder_id

  # Маршрут по умолчанию на интернет-шлюз
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.internet_gateway.id
  }
}

# 🌍 Интернет-шлюз для исходящего трафика
resource "yandex_vpc_gateway" "internet_gateway" {
  name        = "${var.project_name}-${var.environment}-igw"
  description = "Internet gateway for outbound traffic"
  folder_id   = var.yandex_folder_id

  shared_egress_gateway {}
}

# Подсети в разных зонах доступности
resource "yandex_vpc_subnet" "main" {
  for_each = toset(var.availability_zones)
  
  name = "${var.project_name}-${var.environment}-subnet-${split("-", each.value)[2]}"
  
  folder_id      = var.yandex_folder_id
  zone           = each.value
  network_id     = yandex_vpc_network.main.id
  route_table_id = yandex_vpc_route_table.main.id  # ✅ NAT через route table
  v4_cidr_blocks = [cidrsubnet(var.vpc_cidr, 4, index(var.availability_zones, each.value))]
}

# ============================================================
# 🔥 SECURITY GROUP — правила межсетевого экрана
# ============================================================

resource "yandex_vpc_security_group" "k8s_nodes" {
  name        = "${var.project_name}-${var.environment}-k8s-nodes-sg"
  description = "Security group for Kubernetes worker nodes"
  network_id  = yandex_vpc_network.main.id
  folder_id   = var.yandex_folder_id
  
  # === Входящие правила (ingress) ===
  
  # 🔧 SSH для администрирования
  ingress {
    protocol       = "TCP"
    description    = "SSH access for administration"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  
  # 🌐 HTTP/HTTPS для приложений
  ingress {
    protocol       = "TCP"
    description    = "HTTP traffic"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    protocol       = "TCP"
    description    = "HTTPS traffic"
    port           = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  
  # ⚙️ NodePort services Kubernetes
  ingress {
    protocol       = "TCP"
    description    = "Kubernetes NodePort services"
    from_port      = 30000
    to_port        = 32767
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  
  # 🔗 Внутренняя коммуникация кластера
  # ✅ Исправлено: self = true → явное указание CIDR сети
  ingress {
    protocol       = "ANY"
    description    = "Internal cluster communication"
    v4_cidr_blocks = [var.vpc_cidr]  # ✅ Разрешаем трафик внутри сети
  }
  
  # === Исходящие правила (egress) ===
  egress {
    protocol       = "ANY"
    description    = "Allow all outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}