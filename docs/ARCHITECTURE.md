# AI Client Acquisition Agent — Architecture

## Overview

An end-to-end AI-powered system that automatically discovers, qualifies, and converts potential clients for an AI Automation Service. Built with n8n, PostgreSQL, and external APIs.

## System Flow

```
                    ┌─────────────────────────────┐
                    │   AI CLIENT ACQUISITION     │
                    │          AGENT              │
                    │                             │
                    │ Goal: Get clients for my   │
                    │ AI Automation Service       │
                    └──────────────┬──────────────┘
                                   │
                                   ▼
                    ┌─────────────────────────────┐
                    │      1. OFFER + ICP          │
                    │                             │
                    │ • Define service            │
                    │ • Define ideal customer     │
                    │ • Industry                  │
                    │ • Company size              │
                    │ • Location                  │
                    │ • Pain points               │
                    └──────────────┬──────────────┘
                                   │
                                   ▼
                    ┌─────────────────────────────┐
                    │       2. LEAD DISCOVERY      │
                    │                             │
                    │          Apify              │
                    │             │               │
                    │             ▼               │
                    │      Find companies         │
                    │             │               │
                    │             ▼               │
                    │      Find contacts          │
                    │             │               │
                    │             ▼               │
                    │       Deduplicate            │
                    └──────────────┬──────────────┘
                                   │
                                   ▼
                    ┌─────────────────────────────┐
                    │       3. COMPANY RESEARCH    │
                    │                             │
                    │ • Website                   │
                    │ • Services                  │
                    │ • Industry                  │
                    │ • Company size              │
                    │ • Technology                │
                    │ • Business signals          │
                    │ • Potential problems        │
                    └──────────────┬──────────────┘
                                   │
                                   ▼
                    ┌─────────────────────────────┐
                    │       4. AI QUALIFICATION    │
                    │                             │
                    │        LLM / AI             │
                    │             │               │
                    │             ▼               │
                    │       Lead Scoring           │
                    │                             │
                    │ • ICP Fit                   │
                    │ • Pain Signal               │
                    │ • Buying Potential          │
                    │ • Confidence                │
                    │                             │
                    │ Output: 0 ──────── 100      │
                    └──────────────┬──────────────┘
                                   │
                          ┌────────┴────────┐
                          │                 │
                       LOW SCORE          GOOD FIT
                          │                 │
                          ▼                 ▼
                    ┌────────────┐   ┌──────────────────┐
                    │   IGNORE   │   │ 5. PERSONALIZE   │
                    │ / ARCHIVE  │   │                  │
                    └────────────┘   │ • Pain point     │
                                     │ • Evidence       │
                                     │ • Angle          │
                                     │ • Email          │
                                     └────────┬─────────┘
                                              │
                                              ▼
                                     ┌──────────────────┐
                                     │ 6. HUMAN APPROVAL │
                                     │                  │
                                     │ Review AI email  │
                                     │                  │
                                     │  APPROVE / EDIT  │
                                     │       / REJECT   │
                                     └────────┬─────────┘
                                              │
                                           APPROVE
                                              │
                                              ▼
                                     ┌──────────────────┐
                                     │  7. OUTREACH     │
                                     │                  │
                                     │      Gmail       │
                                     │        │         │
                                     │        ▼         │
                                     │    Send Email    │
                                     └────────┬─────────┘
                                              │
                                              ▼
                                     ┌──────────────────┐
                                     │  8. REPLY AGENT  │
                                     │                  │
                                     │ Incoming Reply   │
                                     │        │         │
                                     │        ▼         │
                                     │    AI Classify   │
                                     └────────┬─────────┘
                                              │
                  ┌───────────────┬───────────┼──────────────┬──────────────┐
                  ▼               ▼           ▼              ▼              ▼
             INTERESTED      QUESTION      OOO       NOT INTERESTED   UNSUBSCRIBE
                  │               │           │              │              │
                  ▼               ▼           ▼              ▼              ▼
             BOOK MEETING    HUMAN / AI    FOLLOW UP       STOP         STOP
                  │
                  ▼
             ┌──────────────┐
             │   9. CLIENT  │
             │   CONVERSION │
             │              │
             │ Discovery    │
             │     ↓        │
             │ Proposal     │
             │     ↓        │
             │   Client     │
             └──────┬───────┘
                    │
                    ▼
             ┌──────────────────┐
             │ 10. GTM LEARNING │
             │                  │
             │ Analyze:         │
             │ • Best ICP       │
             │ • Best industry  │
             │ • Best pain      │
             │ • Best offer     │
             │ • Best message   │
             │ • Reply rate     │
             │ • Meeting rate   │
             │ • Conversion     │
             └────────┬─────────┘
                      │
                      │ LEARNING LOOP
                      └──────────────► ICP / OFFER / OUTREACH
```

---

## Phase Breakdown

### Phase 1 — Offer + ICP Definition

Define who you're targeting and what you're selling.

| Field | Description |
|-------|-------------|
| **Service** | AI Automation Service |
| **Industry** | Target verticals |
| **Company Size** | Employee count range |
| **Location** | Geographic focus |
| **Pain Points** | Problems your service solves |

**Storage:** `offers` and `icp_profiles` tables in PostgreSQL

---

### Phase 2 — Lead Discovery

Use **Apify** to scrape and find potential companies + contacts.

| Step | Tool | Action |
|------|------|--------|
| Find companies | Apify (LinkedIn/Google scraper) | Search by ICP criteria |
| Find contacts | Apify (Email finder) | Get decision-maker emails |
| Deduplicate | n8n + PostgreSQL | Remove duplicates by domain/email |

**n8n Workflow:** `01-lead-discovery`
**Storage:** `leads` table

---

### Phase 3 — Company Research

Gather intelligence on each discovered lead.

| Signal | Source |
|--------|--------|
| Website & Services | Web scraping |
| Industry | LinkedIn / Google |
| Company Size | LinkedIn / crunchbase |
| Tech Stack | BuiltWith / Wappalyzer |
| Business Signals | News, hiring, funding |
| Potential Problems | Job postings, reviews |

**n8n Workflow:** `02-company-research`
**Storage:** `company_research` table

---

### Phase 4 — AI Qualification

Use LLM to score and qualify leads.

**Scoring Dimensions (0–100):**

| Factor | Weight | Description |
|--------|--------|-------------|
| ICP Fit | 30% | How well they match your ideal profile |
| Pain Signal | 25% | Evidence of problems you can solve |
| Buying Potential | 25% | Budget, timing, authority |
| Confidence | 20% | Data quality and completeness |

**Decision:**
- Score **≥ 60** → Proceed to personalization
- Score **< 60** → Archive / ignore

**n8n Workflow:** `03-ai-qualification`
**Storage:** `lead_scores` table

---

### Phase 5 — Personalize Outreach

AI generates a personalized email for each qualified lead.

| Element | Description |
|---------|-------------|
| Pain Point | Their specific problem |
| Evidence | Proof you found it |
| Angle | Why your solution fits |
| Email | Complete outreach message |

**n8n Workflow:** `04-personalize-outreach`
**Storage:** `outreach_drafts` table

---

### Phase 6 — Human Approval

Before sending, a human reviews and approves.

| Action | Result |
|--------|--------|
| **Approve** | Email queued for sending |
| **Edit** | Modify and approve |
| **Reject** | Archive lead |

**n8n Workflow:** `05-human-approval`
**Storage:** `approval_queue` table

---

### Phase 7 — Outreach (Send Email)

Approved emails are sent via **Gmail API**.

**n8n Workflow:** `06-send-outreach`
**Storage:** `sent_emails` table

---

### Phase 8 — Reply Agent

AI classifies incoming replies and routes them.

| Classification | Action |
|----------------|--------|
| **Interested** | Book meeting → Book a meeting |
| **Question** | Human or AI responds |
| **OOO** | Follow up later |
| **Not Interested** | Stop outreach |
| **Unsubscribe** | Stop + remove from list |

**n8n Workflow:** `07-reply-agent`
**Storage:** `replies` table

---

### Phase 9 — Client Conversion

When a lead is interested, convert them.

| Step | Action |
|------|--------|
| Discovery Call | Schedule & conduct |
| Proposal | Send custom proposal |
| Close | Onboard as client |

**Storage:** `clients` table

---

### Phase 10 — GTM Learning Loop

Continuously analyze what works and improve.

| Metric | Use |
|--------|-----|
| Best ICP | Refine targeting |
| Best Industry | Focus verticals |
| Best Pain | Sharpen messaging |
| Best Offer | Optimize value prop |
| Best Message | A/B test copy |
| Reply Rate | Measure engagement |
| Meeting Rate | Measure interest |
| Conversion Rate | Measure success |

**Feedback Loop:** Insights feed back into **Phase 1 (ICP/Offer)** and **Phase 5 (Personalization)**

---

## Database Schema (Planned)

```sql
-- Core tables
leads              -- Discovered contacts
company_research   -- Intelligence data
lead_scores        -- AI qualification scores
outreach_drafts    -- Personalized emails
approval_queue     -- Pending human review
sent_emails        -- Sent outreach
replies            -- Incoming responses
clients            -- Converted clients
campaigns          -- Campaign tracking
ai_logs            -- LLM prompt/response logs
gtm_metrics        -- Learning loop analytics
```

---

## Tech Stack

| Component | Tool | Purpose |
|-----------|------|---------|
| Workflow Engine | n8n | Orchestrate all phases |
| Database | PostgreSQL | Store all data |
| Lead Scraping | Apify | Find companies & contacts |
| AI/LLM | OpenAI | Qualification + personalization |
| Email | Gmail API | Send outreach |
| Monitoring | n8n + PostgreSQL | Track metrics |

---

## Directory Mapping

| Phase | Workflow File | DB Tables |
|-------|--------------|-----------|
| 1. Offer + ICP | `config/icp.json` | `icp_profiles` |
| 2. Lead Discovery | `workflows/01-lead-discovery.json` | `leads` |
| 3. Company Research | `workflows/02-company-research.json` | `company_research` |
| 4. AI Qualification | `workflows/03-ai-qualification.json` | `lead_scores` |
| 5. Personalize | `workflows/04-personalize-outreach.json` | `outreach_drafts` |
| 6. Human Approval | `workflows/05-human-approval.json` | `approval_queue` |
| 7. Outreach | `workflows/06-send-outreach.json` | `sent_emails` |
| 8. Reply Agent | `workflows/07-reply-agent.json` | `replies` |
| 9. Conversion | `workflows/08-client-conversion.json` | `clients` |
| 10. GTM Learning | `workflows/09-gtm-learning.json` | `gtm_metrics` |
