#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Personal AI GTM Agent — Setup"
echo "================================="

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Install it from https://docs.docker.com/get-docker/"
    exit 1
fi

# Check Docker Compose
if ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose not found."
    exit 1
fi

# Create .env if missing
if [ ! -f .env ]; then
    echo "📋 Creating .env from .env.example..."
    cp .env.example .env
    echo "✅ .env created — edit it with your own secrets!"
else
    echo "✅ .env already exists"
fi

# Start services
echo "🐳 Starting Docker services..."
docker compose up -d

# Wait for PostgreSQL
echo "⏳ Waiting for PostgreSQL..."
sleep 5

if docker exec gtm-postgres pg_isready -U gtm_user &> /dev/null; then
    echo "✅ PostgreSQL is ready"
else
    echo "⚠️  PostgreSQL might not be ready yet. Check with: docker compose logs postgres"
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "  n8n:         http://localhost:5678"
echo "  PostgreSQL:  localhost:5432"
echo ""
echo "  Default n8n login: admin / changeme"
echo "  (Change these in .env)"
