#!/bin/bash

set -e

printf "[all]\n"

for num in 1 2 3
do
printf "node-$num   ansible_host="
terraform output -json k8s_node_IP | jq -j ".[$num-1]"
printf "   ip="
terraform output -json k8s_node_IP | jq -j ".[$num-1]"
printf "   etcd_member_name=etcd-$num\n"
done

for num in 1
do
printf "cp-$num   ansible_host="
terraform output -json k8s_cp_nat_IP | jq -j ".[$num-1]"
printf "   ip="
terraform output -json k8s_cp_IP | jq -j ".[$num-1]"
printf "\n"
done

for num in 1
do
printf "worker-$num   ansible_host="
terraform output -json k8s_cp_nat_IP | jq -j ".[$num-1]"
printf "   ip="
terraform output -json k8s_cp_IP | jq -j ".[$num-1]"
printf "\n"
done

printf "\n[all:vars]\n"
printf "ansible_user=ansible\n"
printf "supplementary_addresses_in_ssl_keys='"
terraform output -json k8s_cp_nat_IP | jq -cj '.'

printf "\n\n"
# ## configure a bastion host if your nodes are not directly reachable
printf "[bastion]"
printf "ansible_user=ansible\n"
printf "bastion ansible_host='"
terraform output -json k8s_deployer_nat_IP | jq -cj '.'
printf "'\n\n"

cat << EOF
[kube_control_plane]
cp-1

[kube_node]
node-1
node-2
node-3

[etcd]
etcd-1
etcd-2
etcd-3

[worker_node]
worker-1

[calico_rr]

[k8s_cluster:children]
kube_control_plane
kube_node
calico_rr
EOF