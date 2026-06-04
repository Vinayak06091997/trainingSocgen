# Assignment 3 Project

This is a new project with:

- `frontend/` — static HTML served by Nginx
- `backend/` — Python Flask REST API
- `PostgreSQL` database
- `k8s/manifest.yaml` — Kubernetes deployment for namespace `vinayakvpn2`

## Build and push images

```bash
cd trainingSocgen/assignment3

docker build -t vinayakvpn/assignment3-backend:latest ./backend

docker build -t vinayakvpn/assignment3-frontend:latest ./frontend

docker push vinayakvpn/assignment3-backend:latest

docker push vinayakvpn/assignment3-frontend:latest
```

## Apply Kubernetes manifest

```bash
kubectl apply -f k8s/manifest.yaml
kubectl get pods -n vinayakvpn2
kubectl get svc -n vinayakvpn2
```
