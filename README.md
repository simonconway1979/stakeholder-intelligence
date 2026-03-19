# Stakeholder Intelligence System

An AI-powered tool that helps product leaders build deep understanding of their stakeholder landscape during onboarding, based on "The First 90 Days" methodology by Michael Watkins.

## Overview

This system treats stakeholder understanding as versioned, evolving intelligence - not static profiles. It separates private political reads from shareable validation documents, surfaces contradictions across stakeholders, and generates professional "closing the loop" documents to build credibility.

## Key Features

**Two-Layer Intelligence Model:**
- **Private layer:** Honest political reads, contradiction logs, hidden agendas, fear patterns (never shared)
- **Shareable layer:** Fact cards, "closing the loop" documents safe to send to stakeholders

**Core Capabilities:**
- Process interview transcripts into structured insights
- Cross-stakeholder synthesis to find themes and contradictions
- Generate tailored follow-up questions per stakeholder
- Create shareable documents to "close the loop" professionally
- Version tracking (your understanding evolves from week 1 to week 6)

## Components

### 1. Claude Code Skills (9 commands)

Located in `.claude/skills/`:

- `/_add-transcript` - Process interview transcripts into structured insights
- `/_add-note` - Capture informal stakeholder interactions (emails, Slack, hallway chats)
- `/_cross-synthesise` - Analyze patterns across all stakeholders
- `/_generate-questions` - Create tailored follow-up questions
- `/_generate-shareable` - Produce closing-the-loop documents
- `/_export-data` - Export complete project data as JSON
- `/_update-data-export` - Incremental data export updates
- `/_log-touchpoint` - Record informal interactions (deprecated - use `/_add-note`)
- `/_update-context` - Update business context between interview rounds

### 2. Interactive Prototypes

Located in `front-end/`:

**Desktop Version:** `stakeholder-intel-interactive-matrix.html`
- Full stakeholder intelligence dashboard
- Multiple tabs: Matrix, Goals, Questions, Contradictions
- Drag-and-drop stakeholder positioning on influence/interest matrix

**Mobile Version:** `stakeholder-intel-prototype.html`
- Mobile-optimized responsive design with glassmorphism effects
- Instant drag-and-drop with zero lag (direct DOM manipulation)
- Modern UI: pill badges, enhanced spacing, cubic-bezier transitions
- Quadrant labels positioned outside matrix for clarity
- Dropdown selector updates immediately on stakeholder selection

### 3. Example Project

`projects/Talent Bridge (Example)/` - Complete synthetic test scenario with:
- 6 stakeholders with political dynamics
- Full Round 1 interview transcripts
- Cross-stakeholder synthesis
- Contradiction detection
- Influence mapping

## Quick Start

1. Create a new project folder in `projects/[company-name]/`
2. Use `/_add-transcript` to process stakeholder interviews
3. Use `/_cross-synthesise` after completing interview rounds
4. Use `/_generate-shareable` to create closing-the-loop documents
5. Open `front-end/stakeholder-intel-prototype.html` (mobile) or `stakeholder-intel-interactive-matrix.html` (desktop) for visual exploration

## Documentation

- **[Product Strategy](context-library/strategy/product-strategy.md)** - Strategic thesis and competitive differentiation
- **[First 90 Days Methodology](context-library/strategy/first-90-days-methodology.md)** - Foundational framework
- **[PRD v1](context-library/prds/stakeholder-intel-v1.md)** - Full specification
- **[Front-End Plan](front-end/FRONT-END-PLAN.md)** - Design patterns and feature prioritization

## Architecture

**Privacy Model (Non-Negotiable):**
- Private layer: snapshots, synthesis private sections, contradiction logs
- Shareable layer: fact cards, closing-the-loop documents
- Enforcement: `/_generate-shareable` has hardcoded forbidden file list

**File Organization:**
- Each stakeholder: fact card, versioned snapshots, transcripts, relationship log, shareable folder
- Cross-stakeholder analysis: themes, contradictions, influence map, synthesis
- Templates: fact-card, snapshot, synthesis, shareable

## Status

**Built (Week 1):**
- 9 slash commands functional
- 4 template types validated
- Desktop and mobile prototypes
- End-to-end validation with TalentBridge synthetic scenario
- 16+ contradictions surfaced in test data

**Next:**
- Real-world usage pilot
- Co-creation session with collaborator
- Launch decision (product, feature, or consulting tool)

## Technical Stack

- **Frontend:** HTML, Tailwind CSS, vanilla JavaScript
- **Backend:** Claude Code skills (markdown + JavaScript)
- **Visualization:** SVG-based matrix with direct DOM manipulation
- **Data Export:** Structured JSON with schema versioning

---

**Started:** March 2026
**Framework:** Michael Watkins' "The First 90 Days"
**Collaborators:** Simon Conway, Fahad Quraishi
