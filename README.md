# Personal AI GTM Agent

> An AI-powered client acquisition agent that automatically discovers, qualifies, and converts potential clients for your AI Automation Service.

## Architecture

```
                    ┌─────────────────────────────┐
                    │   AI CLIENT ACQUISITION     │
                    │          AGENT              │
                    └──────────────┬──────────────┘
                                   │
                    ┌──────────────▼──────────────┐
                    │      1. OFFER + ICP          │
                    │  Define service & customer   │
                    └──────────────┬──────────────┘
                                   │
                    ┌──────────────▼──────────────┐
                    │       2. LEAD DISCOVERY      │
                    │     Apify → Companies →      │
                    │     Contacts → Deduplicate   │
                    └──────────────┬──────────────┘
                                   │
                    ┌──────────────▼──────────────┐
                    │       3. COMPANY RESEARCH    │
                    │  Website, Tech, Signals      │
                    └──────────────┬──────────────┘
                                   │
                    ┌──────────────▼──────────────┐
                    │       4. AI QUALIFICATION    │
                    │  Lead Score: 0 ──────── 100  │
                    └──────────────┬──────────────┘
                                   │
                          ┌────────┴────────┐
                       LOW SCORE         GOOD FIT
                          │                 │
                          ▼                 ▼
                    ┌──────────┐   ┌──────────────┐
                    │  IGNORE  │   │ 5. PERSONALIZE│
                    └──────────┘   └──────┬───────┘
                                          │
                                 ┌────────▼────────┐
                                 │ 6. HUMAN APPROVAL│
                                 └────────┬────────┘
                                          │
                                 ┌────────▼────────┐
                                 │  7. OUTREACH    │
                                 │    Gmail API     │
                                 └────────┬────────┘
                                          │
                                 ┌────────▼────────┐
                                 │  8. REPLY AGENT │
                                 │  AI Classify     │
                                 └────────┬────────┘
                                          │
                    ┌─────────┬────────────┼───────────┬──────────┐
                    ▼         ▼            ▼           ▼          ▼
               INTERESTED  QUESTION      OOO    NOT INTERESTED UNSUB
                    │         │            │          │          │
                    ▼         ▼            ▼          ▼          ▼
               BOOK MTG   RESPOND     FOLLOW UP     STOP       STOP
                    │
                    ▼
             ┌──────────────┐
             │ 9. CONVERT   │
             │ Discovery →  │
             │ Proposal →   │
             │ Client       │
             └──────┬───────┘
                    │
                    ▼
             ┌──────────────────┐
             │ 10. GTM LEARNING │
             │  Feedback Loop   │
             └──────────────────┘
```

### Stack

| Component | Tool | Purpose |
|-----------|------|---------|
| Workflow Engine | **n8n** | Orchestrate all 10 phases |
| Database | **PostgreSQL** | Store leads, scores, emails, metrics |
| Lead Scraping | **Apify** | Find companies & contacts |
| AI/LLM | **OpenAI** | Qualify leads + personalize emails |
| Email | **Gmail API** | Send outreach |

## Project Structure

```
Personal-AI-GTM-Agent/
├── docker-compose.yml          # PostgreSQL + n8n
├── .env.example                # Environment template
├── README.md
│
├── workflows/                  # n8n workflow exports
│   ├── 01-lead-discovery.json
│   ├── 02-company-research.json
│   ├── 03-ai-qualification.json
│   ├── 04-personalize-outreach.json
│   ├── 05-human-approval.json
│   ├── 06-send-outreach.json
│   ├── 07-reply-agent.json
│   ├── 08-client-conversion.json
│   └── 09-gtm-learning.json
│
├── db/
│   ├── migrations/             # SQL schema files
│   └── seeds/                  # Sample data
│
├── config/
│   └── icp.json                # Ideal Customer Profile
│
├── scripts/
│   ├── setup.sh                # One-click setup
│   ├── backup.sh               # DB backup
│   └── reset.sh                # Reset all data
│
├── docs/
│   └── ARCHITECTURE.md         # Full system design
│
├── api/                        # Backend API (Phase 2+)
└── frontend/                   # Dashboard UI (Phase 3+)
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
- [ ] **Phase 1** — Offer + ICP definition
- [ ] **Phase 2** — Lead discovery with Apify
- [ ] **Phase 3** — Company research
- [ ] **Phase 4** — AI qualification & scoring
- [ ] **Phase 5** — Personalized outreach
- [ ] **Phase 6** — Human approval workflow
- [ ] **Phase 7** — Email outreach via Gmail
- [ ] **Phase 8** — Reply classification agent
- [ ] **Phase 9** — Client conversion
- [ ] **Phase 10** — GTM learning loop

## Docs

- [Architecture](docs/ARCHITECTURE.md) — Full system design & data flow
- [Database](db/README.md) — Migrations and schema
- [Workflows](workflows/README.md) — n8n workflow management

## License

MIT
