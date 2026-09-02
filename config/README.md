# Configuration

Environment and service configuration files.

## Files

| File | Purpose |
|------|---------|
| `.env.example` | Template for environment variables |
| `docker-compose.override.yml` | Local dev overrides (git-ignored) |

## Adding New Services

When adding a new service (Redis, Redis, etc.), update both:
1. `docker-compose.yml` — service definition
2. `.env.example` — required environment variables
