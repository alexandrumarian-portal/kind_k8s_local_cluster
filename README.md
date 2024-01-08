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


