# React + Java + SQL Sample Application

This sample assignment includes:

- `frontend/` — React application served by Nginx
- `backend/` — Java REST API connecting to PostgreSQL
- `docker-compose.yml` — runs frontend, backend, and database together
- `.github/workflows/docker-publish.yml` — builds and pushes Docker images to Docker Hub

## Run locally

From `assignment1/`:

```bash
docker compose up --build
```

Then open:

- Frontend: `http://localhost:3000`
- Backend API: `http://localhost:8081/api/users`

## GitHub Actions

The workflow builds and pushes two images:

- `${{ secrets.DOCKERHUB_USERNAME }}/react-java-frontend:latest`
- `${{ secrets.DOCKERHUB_USERNAME }}/react-java-backend:latest`

Make sure your repository has the following secrets configured:

- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN`
