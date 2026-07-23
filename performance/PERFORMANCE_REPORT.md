# Performance Optimization & Benchmarking Report

## Tool

- Image size check: `docker images`
- Load test: Apache Benchmark (`ab`)

## Test Target

Backend API:

```text
http://localhost:3000/api/message
```

Public backend URL:

```text
http://3.75.203.135:3000/api/message
```

## Benchmark Command

Run on EC2:

```bash
sudo apt update
sudo apt install -y apache2-utils
cd ~/DevOps-Message
TARGET_URL=http://localhost:3000/api/message REQUESTS=1000 CONCURRENCY=50 bash performance/benchmark.sh before
```

After optimization and redeploy:

```bash
git pull origin main
docker compose up -d --build
TARGET_URL=http://localhost:3000/api/message REQUESTS=1000 CONCURRENCY=50 bash performance/benchmark.sh after
```

## Image Optimization

### Before

The backend image already used `node:22-alpine`, but the runtime stage copied the entire build output. This could include unnecessary files if they entered the build context.

The frontend used `nginxinc/nginx-unprivileged:alpine` directly.

### After

Backend Dockerfile improvements:

- Kept multi-stage build
- Used `npm ci --omit=dev --ignore-scripts`
- Copied only production `node_modules`
- Copied only `package*.json` and `server.js` into the runtime image
- Added `backend/.dockerignore`

Frontend Dockerfile improvements:

- Added explicit multi-stage build
- Copied only `index.html` into the final Nginx image
- Added `frontend/.dockerignore`

## Image Size Comparison

Fill this table from `performance/results/before-images.txt` and `performance/results/after-images.txt`.

| Image | Before | After | Change |
|---|---:|---:|---:|
| Backend | TBD | TBD | TBD |
| Frontend | TBD | TBD | TBD |

## Load Test Comparison

Fill this table from `performance/results/before-ab.txt` and `performance/results/after-ab.txt`.

| Metric | Before | After |
|---|---:|---:|
| Requests per second | TBD | TBD |
| Time per request | TBD | TBD |
| Failed requests | TBD | TBD |
| Transfer rate | TBD | TBD |

## Summary

The optimization reduced unnecessary files in the runtime images and made both Dockerfiles use a clearer production-focused build flow. Load testing with Apache Benchmark provides evidence for comparing throughput and response time before and after the image optimization.
