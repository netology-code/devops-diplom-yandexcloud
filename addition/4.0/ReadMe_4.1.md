Пример настройки и развёртывания системы мониторинга используя kube-prometheus.

*Доступ непосредственно к web-интерфейсу prometheus будет реализован при развёртывании приложения на следующих шагах, приведённые данные в данном файле лишь демонстрируют ход предварительного развёртывания и проверки.


# Create the namespace and CRDs, and then wait for them to be available before creating the remaining resources
# Note that due to some CRD size we are using kubectl server-side apply feature which is generally available since kubernetes 1.22.
# If you are using previous kubernetes versions this feature may not be available and you would need to use kubectl create instead.
kubectl apply --server-side -f manifests/setup
kubectl wait \
    --for condition=Established \
    --all CustomResourceDefinition \
    --namespace=monitoring
kubectl apply -f manifests/

# Access UIs

Prometheus, Grafana, and Alertmanager dashboards can be accessed quickly using `kubectl port-forward` after running the quickstart via the commands below. Kubernetes 1.10 or later is required.

> Note: There are instructions on how to route to these pods behind an ingress controller in the [Exposing Prometheus/Alermanager/Grafana via Ingress](customizations/exposing-prometheus-alertmanager-grafana-ingress.md) section.

## Prometheus

```shell
$ kubectl --namespace monitoring port-forward svc/prometheus-k8s 9090
```

Then access via [http://localhost:9090](http://localhost:9090)

## Grafana

```shell
$ kubectl --namespace monitoring port-forward svc/grafana 3000
```

Then access via [http://localhost:3000](http://localhost:3000) and use the default grafana user:password of `admin:admin`.

## Alert Manager

```shell
$ kubectl --namespace monitoring port-forward svc/alertmanager-main 9093
```

Then access via [http://localhost:9093](http://localhost:9093)


# Ход развёртывания:

```
iva@c9v:~/Documents/Diplom/4.0 $ git clone https://github.com/prometheus-operator/kube-prometheus.git
Cloning into 'kube-prometheus'...
remote: Enumerating objects: 17477, done.
remote: Counting objects: 100% (30/30), done.
remote: Compressing objects: 100% (24/24), done.
remote: Total 17477 (delta 10), reused 13 (delta 5), pack-reused 17447
Receiving objects: 100% (17477/17477), 9.07 MiB | 9.67 MiB/s, done.
Resolving deltas: 100% (11508/11508), done.
iva@c9v:~/Documents/Diplom/4.0 $ cd kube-prometheus/
iva@c9v:~/Documents/Diplom/4.0/kube-prometheus  (main)$ kubectl apply --server-side -f manifests/setup
customresourcedefinition.apiextensions.k8s.io/alertmanagerconfigs.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/alertmanagers.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/podmonitors.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/probes.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/prometheuses.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/prometheusrules.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/servicemonitors.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/thanosrulers.monitoring.coreos.com serverside-applied
namespace/monitoring serverside-applied
iva@c9v:~/Documents/Diplom/4.0/kube-prometheus  (main)$ kubectl wait \
        --for condition=Established \
        --all CustomResourceDefinition \
        --namespace=monitoring
customresourcedefinition.apiextensions.k8s.io/alertmanagerconfigs.monitoring.coreos.com condition met
customresourcedefinition.apiextensions.k8s.io/alertmanagers.monitoring.coreos.com condition met
customresourcedefinition.apiextensions.k8s.io/bgpconfigurations.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/bgppeers.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/blockaffinities.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/caliconodestatuses.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/clusterinformations.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/felixconfigurations.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/globalnetworkpolicies.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/globalnetworksets.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/hostendpoints.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/ipamblocks.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/ipamconfigs.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/ipamhandles.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/ippools.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/ipreservations.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/kubecontrollersconfigurations.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/networkpolicies.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/networksets.crd.projectcalico.org condition met
customresourcedefinition.apiextensions.k8s.io/podmonitors.monitoring.coreos.com condition met
customresourcedefinition.apiextensions.k8s.io/probes.monitoring.coreos.com condition met
customresourcedefinition.apiextensions.k8s.io/prometheuses.monitoring.coreos.com condition met
customresourcedefinition.apiextensions.k8s.io/prometheusrules.monitoring.coreos.com condition met
customresourcedefinition.apiextensions.k8s.io/servicemonitors.monitoring.coreos.com condition met
customresourcedefinition.apiextensions.k8s.io/thanosrulers.monitoring.coreos.com condition met
iva@c9v:~/Documents/Diplom/4.0/kube-prometheus  (main)$ kubectl apply -f manifests/
alertmanager.monitoring.coreos.com/main created
networkpolicy.networking.k8s.io/alertmanager-main created
poddisruptionbudget.policy/alertmanager-main created
prometheusrule.monitoring.coreos.com/alertmanager-main-rules created
secret/alertmanager-main created
service/alertmanager-main created
serviceaccount/alertmanager-main created
servicemonitor.monitoring.coreos.com/alertmanager-main created
clusterrole.rbac.authorization.k8s.io/blackbox-exporter created
clusterrolebinding.rbac.authorization.k8s.io/blackbox-exporter created
configmap/blackbox-exporter-configuration created
deployment.apps/blackbox-exporter created
networkpolicy.networking.k8s.io/blackbox-exporter created
service/blackbox-exporter created
serviceaccount/blackbox-exporter created
servicemonitor.monitoring.coreos.com/blackbox-exporter created
secret/grafana-config created
secret/grafana-datasources created
configmap/grafana-dashboard-alertmanager-overview created
configmap/grafana-dashboard-apiserver created
configmap/grafana-dashboard-cluster-total created
configmap/grafana-dashboard-controller-manager created
configmap/grafana-dashboard-grafana-overview created
configmap/grafana-dashboard-k8s-resources-cluster created
configmap/grafana-dashboard-k8s-resources-namespace created
configmap/grafana-dashboard-k8s-resources-node created
configmap/grafana-dashboard-k8s-resources-pod created
configmap/grafana-dashboard-k8s-resources-workload created
configmap/grafana-dashboard-k8s-resources-workloads-namespace created
configmap/grafana-dashboard-kubelet created
configmap/grafana-dashboard-namespace-by-pod created
configmap/grafana-dashboard-namespace-by-workload created
configmap/grafana-dashboard-node-cluster-rsrc-use created
configmap/grafana-dashboard-node-rsrc-use created
configmap/grafana-dashboard-nodes-darwin created
configmap/grafana-dashboard-nodes created
configmap/grafana-dashboard-persistentvolumesusage created
configmap/grafana-dashboard-pod-total created
configmap/grafana-dashboard-prometheus-remote-write created
configmap/grafana-dashboard-prometheus created
configmap/grafana-dashboard-proxy created
configmap/grafana-dashboard-scheduler created
configmap/grafana-dashboard-workload-total created
configmap/grafana-dashboards created
deployment.apps/grafana created
networkpolicy.networking.k8s.io/grafana created
prometheusrule.monitoring.coreos.com/grafana-rules created
service/grafana created
serviceaccount/grafana created
servicemonitor.monitoring.coreos.com/grafana created
prometheusrule.monitoring.coreos.com/kube-prometheus-rules created
clusterrole.rbac.authorization.k8s.io/kube-state-metrics created
clusterrolebinding.rbac.authorization.k8s.io/kube-state-metrics created
deployment.apps/kube-state-metrics created
networkpolicy.networking.k8s.io/kube-state-metrics created
prometheusrule.monitoring.coreos.com/kube-state-metrics-rules created
service/kube-state-metrics created
serviceaccount/kube-state-metrics created
servicemonitor.monitoring.coreos.com/kube-state-metrics created
prometheusrule.monitoring.coreos.com/kubernetes-monitoring-rules created
servicemonitor.monitoring.coreos.com/kube-apiserver created
servicemonitor.monitoring.coreos.com/coredns created
servicemonitor.monitoring.coreos.com/kube-controller-manager created
servicemonitor.monitoring.coreos.com/kube-scheduler created
servicemonitor.monitoring.coreos.com/kubelet created
clusterrole.rbac.authorization.k8s.io/node-exporter created
clusterrolebinding.rbac.authorization.k8s.io/node-exporter created
daemonset.apps/node-exporter created
networkpolicy.networking.k8s.io/node-exporter created
prometheusrule.monitoring.coreos.com/node-exporter-rules created
service/node-exporter created
serviceaccount/node-exporter created
servicemonitor.monitoring.coreos.com/node-exporter created
clusterrole.rbac.authorization.k8s.io/prometheus-k8s created
clusterrolebinding.rbac.authorization.k8s.io/prometheus-k8s created
networkpolicy.networking.k8s.io/prometheus-k8s created
poddisruptionbudget.policy/prometheus-k8s created
prometheus.monitoring.coreos.com/k8s created
prometheusrule.monitoring.coreos.com/prometheus-k8s-prometheus-rules created
rolebinding.rbac.authorization.k8s.io/prometheus-k8s-config created
rolebinding.rbac.authorization.k8s.io/prometheus-k8s created
rolebinding.rbac.authorization.k8s.io/prometheus-k8s created
rolebinding.rbac.authorization.k8s.io/prometheus-k8s created
role.rbac.authorization.k8s.io/prometheus-k8s-config created
role.rbac.authorization.k8s.io/prometheus-k8s created
role.rbac.authorization.k8s.io/prometheus-k8s created
role.rbac.authorization.k8s.io/prometheus-k8s created
service/prometheus-k8s created
serviceaccount/prometheus-k8s created
servicemonitor.monitoring.coreos.com/prometheus-k8s created
apiservice.apiregistration.k8s.io/v1beta1.metrics.k8s.io created
clusterrole.rbac.authorization.k8s.io/prometheus-adapter created
clusterrole.rbac.authorization.k8s.io/system:aggregated-metrics-reader created
clusterrolebinding.rbac.authorization.k8s.io/prometheus-adapter created
clusterrolebinding.rbac.authorization.k8s.io/resource-metrics:system:auth-delegator created
clusterrole.rbac.authorization.k8s.io/resource-metrics-server-resources created
configmap/adapter-config created
deployment.apps/prometheus-adapter created
networkpolicy.networking.k8s.io/prometheus-adapter created
poddisruptionbudget.policy/prometheus-adapter created
rolebinding.rbac.authorization.k8s.io/resource-metrics-auth-reader created
service/prometheus-adapter created
serviceaccount/prometheus-adapter created
servicemonitor.monitoring.coreos.com/prometheus-adapter created
clusterrole.rbac.authorization.k8s.io/prometheus-operator created
clusterrolebinding.rbac.authorization.k8s.io/prometheus-operator created
deployment.apps/prometheus-operator created
networkpolicy.networking.k8s.io/prometheus-operator created
prometheusrule.monitoring.coreos.com/prometheus-operator-rules created
service/prometheus-operator created
serviceaccount/prometheus-operator created
servicemonitor.monitoring.coreos.com/prometheus-operator created
iva@c9v:~/Documents/Diplom/4.0/kube-prometheus  (main)$ 

```

```
iva@c9v:~/Documents/Diplom/4.0/kube-prometheus  (main)$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                       READY   STATUS    RESTARTS   AGE
kube-system   calico-kube-controllers-75748cc9fd-gfgkb   1/1     Running   0          28h
kube-system   calico-node-bnxb2                          1/1     Running   0          28h
kube-system   calico-node-cw7fp                          1/1     Running   1          28h
kube-system   calico-node-nsgcj                          1/1     Running   0          28h
kube-system   calico-node-qzdf8                          1/1     Running   0          28h
kube-system   coredns-588bb58b94-c4qmw                   1/1     Running   0          28h
kube-system   coredns-588bb58b94-kxzpt                   1/1     Running   0          28h
kube-system   dns-autoscaler-5b9959d7fc-94ljn            1/1     Running   0          28h
kube-system   kube-apiserver-cp1                         1/1     Running   1          28h
kube-system   kube-controller-manager-cp1                1/1     Running   1          28h
kube-system   kube-proxy-2ht95                           1/1     Running   0          28h
kube-system   kube-proxy-j2hq2                           1/1     Running   0          28h
kube-system   kube-proxy-pn7fh                           1/1     Running   0          28h
kube-system   kube-proxy-vm2d6                           1/1     Running   0          28h
kube-system   kube-scheduler-cp1                         1/1     Running   1          28h
kube-system   nginx-proxy-node1                          1/1     Running   0          28h
kube-system   nginx-proxy-node2                          1/1     Running   0          28h
kube-system   nginx-proxy-node3                          1/1     Running   0          28h
kube-system   nodelocaldns-7c4ns                         1/1     Running   0          28h
kube-system   nodelocaldns-7ln6t                         1/1     Running   0          28h
kube-system   nodelocaldns-8n7k6                         1/1     Running   0          28h
kube-system   nodelocaldns-bnhmf                         1/1     Running   0          28h
monitoring    alertmanager-main-0                        2/2     Running   0          115s
monitoring    alertmanager-main-1                        2/2     Running   0          115s
monitoring    alertmanager-main-2                        2/2     Running   0          115s
monitoring    blackbox-exporter-6fd586b445-tcmg8         3/3     Running   0          2m29s
monitoring    grafana-9f58f8675-9p24g                    1/1     Running   0          2m18s
monitoring    kube-state-metrics-66659c89c-jl9nt         3/3     Running   0          2m16s
monitoring    node-exporter-92b6n                        2/2     Running   0          2m14s
monitoring    node-exporter-hjzzl                        2/2     Running   0          2m14s
monitoring    node-exporter-pc4q7                        2/2     Running   0          2m14s
monitoring    node-exporter-pxws2                        2/2     Running   0          2m14s
monitoring    prometheus-adapter-757f9b4cf9-msw97        1/1     Running   0          2m11s
monitoring    prometheus-adapter-757f9b4cf9-zw4bm        1/1     Running   0          2m11s
monitoring    prometheus-k8s-0                           2/2     Running   0          114s
monitoring    prometheus-k8s-1                           2/2     Running   0          114s
monitoring    prometheus-operator-776c6c6b87-xhdpn       2/2     Running   0          2m11s

```