# DevSecOps Hardening Report

## Tool

- Source dependency scan: `npm audit`
- Docker image/source scan workflow: `Trivy` via GitHub Actions

## Before Remediation

### npm audit summary

Baseline scan file:

```text
backend/security-reports/npm-audit-before.json
```

Result:

| Severity | Count |
|---|---:|
| Critical | 0 |
| High | 2 |
| Medium | 2 |
| Low | 0 |
| Total | 4 |

Important findings:

1. `path-to-regexp` Regular Expression Denial of Service via Express dependency chain
2. `qs` remotely triggerable denial of service
3. `body-parser` denial of service risk

### Dockerfile baseline findings

Baseline scan file:

```text
security-reports/dockerfile-audit-before.md
```

Main risks:

1. Backend used older `node:18` / `node:18-slim` images
2. Backend container ran as root by default
3. Frontend used default `nginx:alpine` image and privileged port `80`

## Remediation

### 1. Updated backend dependencies

Updated backend dependencies:

```bash
npm install express@latest cors@latest
```

Result after update:

```text
found 0 vulnerabilities
```

### 2. Hardened backend Dockerfile

Changes:

- Replaced `node:18` with `node:22-alpine`
- Replaced `npm install` with `npm ci --omit=dev`
- Set `NODE_ENV=production`
- Copied files with `--chown=node:node`
- Added `USER node` so the runtime container does not run as root

### 3. Hardened frontend Dockerfile

Changes:

- Replaced `nginx:alpine` with `nginxinc/nginx-unprivileged:alpine`
- Exposed unprivileged port `8080`
- Removed unnecessary Node build stage

### 4. Hardened docker-compose.yml

Changes:

- Removed obsolete `version` field
- Added `security_opt: no-new-privileges:true`
- Updated frontend port mapping to `8080:8080`

## After Remediation

After dependency update:

| Severity | Count |
|---|---:|
| Critical | 0 |
| High | 0 |
| Medium | 0 |
| Low | 0 |
| Total | 0 |

Command:

```bash
npm audit
```

Result:

```text
found 0 vulnerabilities
```

## Trivy Scan Workflow

The project includes a GitHub Actions workflow for Trivy scanning:

```text
.github/workflows/security-scan.yml
```

The workflow scans:

- Source code and configuration
- Backend Docker image
- Frontend Docker image

Severity levels included:

```text
CRITICAL,HIGH,MEDIUM
```

## Summary

At least 3 important security improvements were completed:

1. Updated vulnerable Express dependency chain from 4 reported vulnerabilities to 0 npm vulnerabilities
2. Changed backend container to run as non-root user
3. Replaced default nginx image with unprivileged nginx image
4. Added `no-new-privileges` to Docker Compose services
5. Added Trivy scan workflow for automated DevSecOps checks
