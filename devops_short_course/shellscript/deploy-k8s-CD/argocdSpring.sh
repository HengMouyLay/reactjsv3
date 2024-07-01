#!/bin/bash
repoURL=$1

YAML_CONTENT=$(cat <<EOF
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: spring-application
  namespace: argocd
spec:
  project: default
  source:
    repoURL: ${repoURL}
    targetRevision: main
    path: .
  destination:
    namespace: default
    server: https://kubernetes.default.svc
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - Validate=false           
EOF
)

# Create a temporary file to store the Argo CD Application YAML
TMP_FILE=$(mktemp)
echo "$YAML_CONTENT" > "$TMP_FILE"

# Apply the Argo CD Application YAML
kubectl apply -f "$TMP_FILE"

# Clean up the temporary file
rm "$TMP_FILE"