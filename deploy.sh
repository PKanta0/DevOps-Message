#!/usr/bin/env bash
set -euo pipefail

APP_DIR="${APP_DIR:-$HOME/DevOps-Message}"
REPO_URL="${REPO_URL:-https://github.com/PKanta0/DevOps-Message.git}"
BRANCH="${BRANCH:-main}"

if [ ! -d "$APP_DIR/.git" ]; then
  git clone --branch "$BRANCH" "$REPO_URL" "$APP_DIR"
fi

cd "$APP_DIR"
git fetch origin "$BRANCH"
git reset --hard "origin/$BRANCH"
docker compose up -d --build
docker ps
