#!/usr/bin/env bash
set -euo pipefail

echo "⚠️  This will DELETE all data (PostgreSQL, n8n workflows)."
read -p "Are you sure? (y/N) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🗑️  Stopping services and removing volumes..."
    docker compose down -v
    echo "✅ All data reset. Run './scripts/setup.sh' to start fresh."
else
    echo "❌ Cancelled."
fi
