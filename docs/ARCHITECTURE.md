# Architecture

## System Overview

```
┌──────────────────────────────────────────────────────────┐
│                      YOUR MACHINE                         │
│                                                          │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐  │
│  │   n8n UI    │    │   Frontend  │    │   API       │  │
│  │  :5678      │    │   (TBD)    │    │   (TBD)    │  │
│  └──────┬──────┘    └──────┬──────┘    └──────┬──────┘  │
│         │                  │                  │          │
│         └──────────┬───────┴──────────────────┘          │
│                    │                                     │
│         ┌──────────▼──────────┐                          │
│         │    PostgreSQL       │                          │
│         │    :5432            │                          │
│         └─────────────────────┘                          │
└──────────────────────────────────────────────────────────┘
                    │
                    ▼
            ┌───────────────┐
            │  External APIs │
            │  - OpenAI      │
            │  - Email       │
            │  - Social      │
            └───────────────┘
```

## Data Flow

1. **Lead Ingestion** — n8n webhooks receive leads from forms, CSVs, or APIs
2. **AI Enrichment** — OpenAI processes and enriches lead data
3. **Storage** — Enriched data stored in PostgreSQL
4. **Outreach** — n8n triggers email/social campaigns
5. **Tracking** — Interactions logged back to database

## Directory Structure

```
Personal-AI-GTM-Agent/
├── docker-compose.yml     # Service orchestration
├── .env.example           # Environment template
│
├── workflows/             # n8n workflow exports (JSON)
├── db/
│   ├── migrations/        # SQL migration files
│   └── seeds/             # Sample data
│
├── api/                   # Backend API (Phase 2+)
├── frontend/              # Dashboard UI (Phase 3+)
│
├── config/                # Configuration files
├── scripts/               # Dev/ops helper scripts
├── docs/                  # Documentation
│   └── ARCHITECTURE.md    # This file
│
└── backups/               # DB backups (git-ignored)
```
