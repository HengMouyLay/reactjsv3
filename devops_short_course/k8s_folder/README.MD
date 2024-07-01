# Kube Configuration

## Deployment

1. Adding or Modifying Node Labels

```bash
kubectl label nodes <node-name> key=value --overwrite
```

Replace <node-name> with the name of the node, key with the label key, and value with the label value. The --overwrite flag allows you to replace an existing label if it's already set.Example:

```bash
kubectl label nodes node3 hardware=high-spec --overwrite

```
2. Check Node Labels: You can check the labels assigned to a node by using:
```bash
kubectl get nodes --show-labels

```
Or to see the labels of a specific node:
```bash
kubectl get node node3 --show-labels

```

## Removing Labels from Nodes
```bash
kubectl label nodes node3 hardware-
```
##  Using Node Labels for Pod Scheduling
```bash
apiVersion: apps/v1
kind: Deployment
metadata:
  name: specialized-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: specialized-app
  template:
    metadata:
      labels:
        app: specialized-app
    spec:
      containers:
      - name: nginx
        image: nginx
      nodeSelector:
        hardware: high-spec

```
![alt text](image.png)


## Run Manual with specific nodeport
```bash
kubectl expose deployment.apps/my-nginx-deploy --name my-nginx-svc --port=80 --type=NodePort
```

## Copy file index.html to pod
```bash
kubectl cp index.html my-nginx-deploy-5c6b4b8d8f-7z5z2:/usr/share/nginx/html/index.html
```