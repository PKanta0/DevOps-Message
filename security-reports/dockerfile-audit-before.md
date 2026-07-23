# Baseline Dockerfile Findings

## backend/Dockerfile before remediation
- Base image: node:18 / node:18-slim
- Runtime user: root by default
- Dependency install command: npm install
- Risk: older base image line may contain OS/package vulnerabilities and root runtime increases container breakout impact.

## frontend/Dockerfile before remediation
- Base image: nginx:alpine
- Runtime user: root/default nginx image behavior
- Risk: default privileged port 80 and default image user are less hardened than an unprivileged nginx image.
