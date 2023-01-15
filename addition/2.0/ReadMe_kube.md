node-1   ansible_host=10.0.10.33   ip=10.0.10.33   etcd_member_name=etcd-1
node-2   ansible_host=10.0.20.31   ip=10.0.20.31   etcd_member_name=etcd-2
node-3   ansible_host=10.0.30.34   ip=10.0.30.34   etcd_member_name=etcd-3
cp-1   ansible_host=158.160.56.132   ip=10.0.10.29
worker-1   ansible_host=158.160.56.132   ip=10.0.10.29


sudo apt-get update -y && sudo apt-get install git mc python3-pip -y
cd .ssh/
chmod 600 id_rsa
ls -la
clear
cd
ssh ansible@10.0.10.33
ssh ansible@10.0.20.31
ssh ansible@10.0.30.34
ssh ansible@10.0.10.29

git clone https://github.com/kubernetes-sigs/kubespray
cd kubespray/
sudo pip3 install -r requirements.txt
cp -rfp inventory/sample inventory/mycluster
declare -a IPS=(10.0.10.33 10.0.20.31 10.0.30.34 10.0.10.29)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
cd inventory/mycluster/

ansible@deployer:~/kubespray/inventory/mycluster$ cat hosts.yaml 
all:
  hosts:
    node1:
      ansible_host: 10.0.10.33
      ip: 10.0.10.33
      access_ip: 10.0.10.33
    node2:
      ansible_host: 10.0.20.31
      ip: 10.0.20.31
      access_ip: 10.0.20.31
    node3:
      ansible_host: 10.0.30.34
      ip: 10.0.30.34
      access_ip: 10.0.30.34
    cp1:
      ansible_host: 10.0.10.29
      ip: 10.0.10.29
      access_ip: 10.0.10.29
  children:
    kube_control_plane:
      hosts:
        cp1:
    kube_node:
      hosts:
        node1:
        node2:
        node3:
    etcd:
      hosts:
        node1:
        node2:
        node3:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}

Для доступа из-вне необходимо раскоментировать соответствующую настройку в файле k8s-cluster.yml.

~/kubespray/source/mycluster$ cat k8s-cluster.yml | grep suppl
supplementary_addresses_in_ssl_keys: [158.160.56.132]
supplementary_addresses_in_ssl_keys: [51.250.96.56] ->192.168.7.73

Устанавливваем
~/kubespray$
ansible-playbook -i inventory/mycluster/hosts.yaml cluster.yml -b -v

копируем серт для доступа
{     mkdir -p $HOME/.kube;     sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config;     sudo chown $(id -u):$(id -g) $HOME/.kube/config; }

проверяем
kubectl get pods -n kube-system
kubectl get nodes


iva@c9v:~/Documents/devops-diplom-yandexcloud  (2.0 *)$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                       READY   STATUS    RESTARTS   AGE
kube-system   calico-kube-controllers-75748cc9fd-gfgkb   1/1     Running   0          77m
kube-system   calico-node-bnxb2                          1/1     Running   0          78m
kube-system   calico-node-cw7fp                          1/1     Running   1          78m
kube-system   calico-node-nsgcj                          1/1     Running   0          78m
kube-system   calico-node-qzdf8                          1/1     Running   0          78m
kube-system   coredns-588bb58b94-c4qmw                   1/1     Running   0          77m
kube-system   coredns-588bb58b94-kxzpt                   1/1     Running   0          77m
kube-system   dns-autoscaler-5b9959d7fc-94ljn            1/1     Running   0          77m
kube-system   kube-apiserver-cp1                         1/1     Running   1          79m
kube-system   kube-controller-manager-cp1                1/1     Running   1          79m
kube-system   kube-proxy-2ht95                           1/1     Running   0          78m
kube-system   kube-proxy-j2hq2                           1/1     Running   0          78m
kube-system   kube-proxy-pn7fh                           1/1     Running   0          78m
kube-system   kube-proxy-vm2d6                           1/1     Running   0          78m
kube-system   kube-scheduler-cp1                         1/1     Running   1          79m
kube-system   nginx-proxy-node1                          1/1     Running   0          77m
kube-system   nginx-proxy-node2                          1/1     Running   0          77m
kube-system   nginx-proxy-node3                          1/1     Running   0          77m
kube-system   nodelocaldns-7c4ns                         1/1     Running   0          77m
kube-system   nodelocaldns-7ln6t                         1/1     Running   0          77m
kube-system   nodelocaldns-8n7k6                         1/1     Running   0          77m
kube-system   nodelocaldns-bnhmf                         1/1     Running   0          77m
