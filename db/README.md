# Database

PostgreSQL schemas, migrations, and seed data.

## Structure

```
db/
├── migrations/    # SQL migration files (run in order)
├── seeds/         # Sample data for development
└── README.md
```

## Running Migrations

```bash
# Connect to PostgreSQL
docker exec -it gtm-postgres psql -U gtm_user -d gtm_agent

# Or run a migration file
docker exec -i gtm-postgres psql -U gtm_user -d gtm_agent < db/migrations/001_init.sql
```

## Tables (Phase 0+)

| Table | Purpose |
|-------|---------|
| `leads` | Contact/company leads |
| `campaigns` | Outreach campaigns |
| `interactions` | Email/call/social touchpoints |
| `ai_logs` | LLM prompt/response logs |
