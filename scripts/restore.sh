#!/usr/bin/env bash

set -e

if [ -z "$1" ]; then
    echo "Usage:"
    echo "./scripts/restore.sh backups/file.dump"
    exit 1
fi

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BACKUP_FILE="$1"

cd "$ROOT_DIR"

set -a
source .env
set +a

if [ ! -f "$BACKUP_FILE" ]; then
    echo "Backup not found: $BACKUP_FILE"
    exit 1
fi

echo "Restoring PostgreSQL database..."

docker compose exec -T postgres \
    pg_restore \
    -U "$POSTGRES_USER" \
    -d "$POSTGRES_DB" \
    --clean \
    --if-exists \
    < "$BACKUP_FILE"

echo "Restore completed."