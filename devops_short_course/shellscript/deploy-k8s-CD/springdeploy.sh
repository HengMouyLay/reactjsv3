#!/bin/bash
fullImageName=$1
YAML_CONTENT=$(cat <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: spring-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: spring-app
  template:
    metadata:
      labels:
        app: spring-app
    spec:
      containers:
        - name: spring-app
          image: ${fullImageName}
          ports:
            - containerPort: 8080
          volumeMounts:
            - name: spring-volume
              mountPath: /images
      volumes:
        - name: spring-volume
          nfs:
            server: 167.172.70.166
            path: /opt/nfs/data/images
          # hostPath:
          #   path: /opt/nfs/data/images
---
apiVersion: v1
kind: Service
metadata:
  name: spring-service
spec:
  selector:
    app: spring-app
  ports:
    - protocol: TCP
      port: 8080
      targetPort: 8080
  type: NodePort            
EOF
)

# Create a temporary file to store the Argo CD Application YAML
TMP_FILE=$(mktemp)
echo "$YAML_CONTENT" > "$TMP_FILE"

# Apply the Argo CD Application YAML
kubectl apply -f "$TMP_FILE"

# Clean up the temporary file
rm "$TMP_FILE"