# Personal AI GTM Agent

> A YouTube tutorial series: Building a personal AI-powered Go-To-Market agent with n8n, PostgreSQL, and automation workflows.

## Architecture

```
┌─────────────────────────────────────────────────┐
│                   n8n (UI:5678)                  │
│         Workflow Automation Engine               │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐      │
│  │ Webhooks │  │ AI Nodes │  │ DB Nodes │      │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘      │
└───────┼──────────────┼──────────────┼────────────┘
        │              │              │
        ▼              ▼              ▼
   External       OpenAI /      PostgreSQL
   Triggers       LLM APIs      (Data Store)
                                 :5432
```

### Stack

| Component   | Purpose                        | Port |
|-------------|--------------------------------|------|
| **n8n**     | Visual workflow automation     | 5678 |
| **PostgreSQL** | Persistent data storage    | 5432 |

## Project Structure

```
Personal-AI-GTM-Agent/
├── docker-compose.yml         # Service orchestration
├── .env.example               # Environment template
│
├── workflows/                 # n8n workflow exports (JSON)
│
├── db/
│   ├── migrations/            # SQL migration files
│   └── seeds/                 # Sample data
│
├── api/                       # Backend API (Phase 2+)
├── frontend/                  # Dashboard UI (Phase 3+)
│
├── config/                    # Configuration files
├── scripts/                   # Dev/ops helper scripts
│   ├── setup.sh               # One-click project setup
│   ├── backup.sh              # PostgreSQL backup
│   └── reset.sh               # Reset all data
│
└── docs/
    └── ARCHITECTURE.md        # System design docs
```

## Quick Start

```bash
# 1. Clone the repo
git clone https://github.com/Girma35/Personal-AI-GTM-Agent.git
cd Personal-AI-GTM-Agent

# 2. Run setup (creates .env + starts Docker)
chmod +x scripts/*.sh
./scripts/setup.sh

# 3. Open n8n
open http://localhost:5678
```

**Default login:** `admin` / `changeme` (change in `.env`)

## Project Phases

- [x] **Phase 0** — Foundation (Docker, PostgreSQL, n8n)
- [ ] **Phase 1** — Lead ingestion & AI enrichment workflows
- [ ] **Phase 2** — Backend API
- [ ] **Phase 3** — Frontend dashboard

## Docs

- [Architecture](docs/ARCHITECTURE.md) — System design and data flow
- [Database](db/README.md) — Migrations and schema
- [Workflows](workflows/README.md) — n8n workflow management

## License

MIT
