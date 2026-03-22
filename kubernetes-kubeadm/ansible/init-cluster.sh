#!/bin/bash
# init-cluster.sh — Инициализация Kubernetes кластера на мастере
# Запускать ТОЛЬКО на мастер-ноде после установки компонентов
set -e

echo "=== Kubernetes Cluster Initialization ==="
echo "Hostname: $(hostname)"
echo "Date: $(date)"
echo "================================"

# Получаем внутренний IP мастера
MASTER_IP=$(hostname -I | awk '{print $1}')
POD_CIDR="${POD_NETWORK_CIDR:-10.244.0.0/16}"

echo "Master IP: $MASTER_IP"
echo "Pod CIDR: $POD_CIDR"

# Инициализация кластера
echo ""
echo "[1/3] Initializing Kubernetes control-plane..."
sudo kubeadm init \
  --control-plane-endpoint="$MASTER_IP" \
  --pod-network-cidr="$POD_CIDR" \
  --ignore-preflight-errors=NumCPU,Mem

# Настройка kubectl для текущего пользователя
echo "[2/3] Configuring kubectl..."
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Установка сетевого плагина (Calico)
echo "[3/3] Installing Calico CNI plugin..."
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# Генерация команды для присоединения рабочих нод
echo ""
echo "=== Join Command for Workers ==="
echo "Скопируйте эту команду и выполните на КАЖДОЙ рабочей ноде:"
echo ""
kubeadm token create --print-join-command
echo ""

# Проверка состояния кластера
echo "=== Cluster Status ==="
kubectl get nodes
kubectl get pods -n kube-system

echo ""
echo "✅ Cluster initialization completed!"