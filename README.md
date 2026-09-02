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

## Quick Start

```bash
# 1. Clone the repo
git clone https://github.com/Girma35/Personal-AI-GTM-Agent.git
cd Personal-AI-GTM-Agent

# 2. Copy environment file
cp .env.example .env

# 3. Start services
docker compose up -d

# 4. Open n8n
open http://localhost:5678
```

## Project Phases

- [x] **Phase 0** — Foundation (Docker, PostgreSQL, n8n)
- [ ] **Phase 1** — [TBD]
- [ ] **Phase 2** — [TBD]
- [ ] **Phase 3** — [TBD]

## License

MIT
