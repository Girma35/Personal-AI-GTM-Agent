#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="./backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="${BACKUP_DIR}/gtm_agent_${TIMESTAMP}.sql.gz"

mkdir -p "$BACKUP_DIR"

echo "💾 Backing up PostgreSQL..."
docker exec gtm-postgres pg_dump -U gtm_user gtm_agent | gzip > "$BACKUP_FILE"

echo "✅ Backup saved: $BACKUP_FILE"
echo "📁 Total backups: $(ls -1 "$BACKUP_DIR"/*.sql.gz 2>/dev/null | wc -l)"
