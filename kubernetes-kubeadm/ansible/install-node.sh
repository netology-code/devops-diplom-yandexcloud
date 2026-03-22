#!/bin/bash
# install-node.sh — Установка Kubernetes компонентов на узел
# Запускать на КАЖДОЙ ноде (мастер + рабочие)
set -e

echo "=== Kubernetes Node Setup ==="
echo "Hostname: $(hostname)"
echo "Date: $(date)"
echo "================================"

# 1. Модули ядра
echo "[1/8] Configuring kernel modules..."
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter

# 2. Сетевые параметры
echo "[2/8] Configuring network parameters..."
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
sudo sysctl --system

# 3. Установка containerd
echo "[3/8] Installing containerd..."
sudo apt-get update -qq
sudo apt-get install -y containerd

# 4. Настройка containerd для Kubernetes
echo "[4/8] Configuring containerd..."
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml > /dev/null
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd

# 5. Подготовка репозитория Kubernetes
echo "[5/8] Adding Kubernetes repository..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | \
  sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | \
  sudo tee /etc/apt/sources.list.d/kubernetes.list

# 6. Установка kubeadm, kubelet, kubectl
echo "[6/8] Installing kubelet, kubeadm, kubectl..."
sudo apt-get update -qq
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# 7. Отключение swap (требуется для kubelet)
echo "[7/8] Disabling swap..."
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# 8. Запуск kubelet
echo "[8/8] Starting kubelet..."
sudo systemctl enable --now kubelet

# Проверка
echo ""
echo "=== Verification ==="
echo "Containerd: $(containerd --version 2>/dev/null | head -1 || echo 'not found')"
echo "Kubeadm: $(kubeadm version -o short 2>/dev/null || echo 'not found')"
echo "Kubelet: $(kubelet --version 2>/dev/null || echo 'not found')"
echo "Kubectl: $(kubectl version --client -o json 2>/dev/null | jq -r '.clientVersion.gitVersion' 2>/dev/null || echo 'not found')"
echo ""
echo "✅ Node setup completed on $(hostname)"