# Database

PostgreSQL schemas, migrations, and seed data for the AI Client Acquisition Agent.

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

## Tables

| Table | Phase | Purpose |
|-------|-------|---------|
| `icp_profiles` | 1 | Ideal customer profile definitions |
| `leads` | 2 | Discovered contacts from Apify |
| `company_research` | 3 | Intelligence gathered on each lead |
| `lead_scores` | 4 | AI qualification scores (0–100) |
| `outreach_drafts` | 5 | Personalized email drafts |
| `approval_queue` | 6 | Emails pending human review |
| `sent_emails` | 7 | Outreach emails that were sent |
| `replies` | 8 | Incoming replies + AI classification |
| `clients` | 9 | Converted clients |
| `campaigns` | — | Campaign tracking |
| `gtm_metrics` | 10 | Learning loop analytics |
| `ai_logs` | — | LLM prompt/response logs |

## ER Overview

```
icp_profiles ──────┐
                    ├──► leads ──► company_research ──► lead_scores
                    │                                    │
                    │                               (score ≥ 60)
                    │                                    │
                    │                              outreach_drafts
                    │                                    │
                    │                              approval_queue
                    │                                    │
                    │                               sent_emails
                    │                                    │
                    │                                  replies
                    │                                    │
                    │                              (INTERESTED)
                    │                                    │
                    │                                  clients
                    │                                    │
                    └──────────── gtm_metrics ◄──────────┘
                              (learning loop)
```
