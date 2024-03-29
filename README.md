# kind K8S local cluster

Get kind binary and install it 
```
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
kind --version
```

 Create Kind Cluster via config file
```
sudo kind create cluster --name vbox-cluster --config kind-cluster.ym
```
Get cluster info 
```
sudo kubectl cluster-info --context kind-vbox-cluster
```

Installing MetalLB using default manifests
```
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml
kubectl wait --namespace metallb-system --for=condition=ready pod --selector=app=metallb --timeout=90s
```

Setup address pool used by loadbalancers
```
docker network inspect -f '{{.IPAM.Config}}' kind
or
podman network inspect -f '{{range .Subnets}}{{if eq (len .Subnet.IP) 4}}{{.Subnet}}{{end}}{{end}}' kind
```

```
cat << EOF > kind-cluster.yml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: example
  namespace: metallb-system
spec:
  addresses:
  - 172.18.255.200-172.18.255.250
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: empty
  namespace: metallb-system

EOF

kubectl create -f kind-cluster.yml
```

Useful links:

https://kind.sigs.k8s.io/docs/user/loadbalancer/





