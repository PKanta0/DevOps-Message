#!/usr/bin/env bash
set -euo pipefail

TARGET_URL="${TARGET_URL:-http://localhost:3000/api/message}"
REQUESTS="${REQUESTS:-1000}"
CONCURRENCY="${CONCURRENCY:-50}"
OUTPUT_DIR="${OUTPUT_DIR:-performance/results}"
LABEL="${1:-benchmark}"

mkdir -p "$OUTPUT_DIR"

if ! command -v ab >/dev/null 2>&1; then
  echo "Apache Benchmark not found. Install it with: sudo apt install -y apache2-utils"
  exit 1
fi

echo "Target: $TARGET_URL"
echo "Requests: $REQUESTS"
echo "Concurrency: $CONCURRENCY"

ab -n "$REQUESTS" -c "$CONCURRENCY" "$TARGET_URL" | tee "$OUTPUT_DIR/${LABEL}-ab.txt"
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" | tee "$OUTPUT_DIR/${LABEL}-images.txt"
