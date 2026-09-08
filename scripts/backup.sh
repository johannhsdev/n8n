#!/usr/bin/env bash

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BACKUP_DIR="$ROOT_DIR/backups"

mkdir -p "$BACKUP_DIR"

cd "$ROOT_DIR"

set -a
source .env
set +a

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
FILE="$BACKUP_DIR/n8n_${TIMESTAMP}.dump"

echo "Creating PostgreSQL backup..."

docker compose exec -T postgres \
    pg_dump \
    -U "$POSTGRES_USER" \
    -d "$POSTGRES_DB" \
    -Fc > "$FILE"

echo "Backup created:"
echo "$FILE"