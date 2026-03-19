# Stakeholder Intelligence

**An AI system that turns 20-40 onboarding interviews into a political map of your organization, with contradictions surfaced, hidden agendas tracked, and polished follow-up documents generated automatically.**

[Live Demo](https://simonconway1979.github.io/stakeholder-intelligence/) | Built with Claude Code

---

## The Problem

Every PM who starts a new role runs the same playbook: schedule 20-40 stakeholder interviews, take notes, try to piece together who really has power, who's aligned, and where the landmines are.

The reality is brutal. Notes end up scattered across Google Docs. Political insights stay in your head because you can't write them down anywhere safe. You miss that the VP of Sales and the Engineering Lead have fundamentally incompatible views on the roadmap. And you never close the loop with stakeholders, so you miss the single fastest way to build credibility in a new role.

The result: it takes weeks to understand the landscape, critical patterns go unnoticed, and you don't build trust as fast as you could.

## The Approach

This system is built on the stakeholder interview methodology from Michael Watkins' *The First 90 Days*, enhanced with AI synthesis and a privacy model that lets you be genuinely candid.

**Three things make it different:**

**1. Private and shareable layers.** Your honest political reads, hidden agenda tracking, and contradiction logs live in a private layer that never leaks into outputs. When you're ready to close the loop with a stakeholder, the system generates a polished, professional document from the shareable layer only. You get to be candid in your analysis and impressive in your communication.

**2. Versioned understanding.** Your read on a stakeholder in week 1 is wrong. By week 6, it's nuanced. This system tracks that evolution with versioned snapshots instead of treating stakeholder understanding as static. You can look back and see how your mental model developed.

**3. Contradiction detection.** The system actively cross-references what different stakeholders tell you and surfaces where they disagree without knowing it. In the demo, you'll see things like: the VP of Sales says the conference deadline is "non-negotiable," the Engineering Lead says it's "exhibit A of the broken pattern," and the Data Scientist learned about it "yesterday." That's not a timeline disagreement. That's an organizational crisis, and it's invisible if you're processing interviews one at a time.

## How It Works

The system has two parts: a Claude Code backend that processes and synthesizes interview data, and an interactive front-end that visualizes the political landscape.

### Backend: Claude Code Slash Commands

The backend runs as a set of slash commands inside Claude Code. You paste in a transcript or notes, and the system does the rest.

| Command | What it does |
|---------|-------------|
| `/_add-transcript` | Process a full interview transcript into structured intelligence: goals, needs, pain points, political read, hidden agendas, key quotes. Updates the versioned snapshot. |
| `/_add-note` | Capture informal interactions (emails, Slack, hallway conversations) without the overhead of a full transcript. |
| `/_cross-synthesise` | Analyze patterns across all stakeholders. Surfaces 3-5 themes, identifies contradictions with quotes, produces an influence map and executive summary. |
| `/_generate-questions` | Create tailored follow-up questions based on what they said, what contradicts others, and what they seemed to hold back. |
| `/_generate-shareable` | Produce a "closing the loop" document safe to send to the stakeholder. Summarizes what you heard, lists commitments, invites correction. Never reads private files. |
| `/_export-data` | Export the complete project as structured JSON for backup, sharing, or feeding into the front-end. |

The workflow is simple: after each interview, run `/_add-transcript`. After a round of interviews, run `/_cross-synthesise`. Before follow-ups, run `/_generate-questions`. To build credibility, run `/_generate-shareable`.

### Front-end: Interactive Political Landscape

The front-end is a single HTML file with no dependencies beyond Tailwind CSS. It visualizes the output of the backend as an interactive tool. **Fully responsive and mobile-optimized** with modern glassmorphism effects, instant drag-and-drop (zero lag), and touch-friendly controls.

**Influence/Interest Matrix** - Stakeholders plotted on a 2x2 grid. Drag to reposition with instant response on both mobile and desktop. Color indicates attitude (red for adversary through green for strong ally). Click any dot to see their full profile.

**Rich Insight Panels** - For each stakeholder: summary, goals, needs, pain points, hidden agendas, key quotes, recommendations, and contradictions. Each section includes AI-synthesized analysis with supporting quotes from actual interviews.

**Cross-Stakeholder Synthesis** - Themes across the organization (consensus, fractured views, strategic silence), key contradictions with severity ratings and implications, and immediate crises requiring action.

**Responsive Design** - Works seamlessly on mobile, tablet, and desktop. Modern UI with pill badges, enhanced spacing, and smooth micro-interactions. Optimized for touch with larger tap targets and immediate visual feedback.

**Keyboard navigation** - Arrow keys to move through insight sections. Dropdown to switch between stakeholders. The interface is designed to feel like an intelligence briefing, not a dashboard.

## What Makes This Different

| Traditional approach | Stakeholder Intelligence |
|---------------------|------------------------|
| Static profiles that never update | Versioned snapshots tracking how understanding evolves |
| Political insights stay in your head | Private layer captures honest reads, hidden agendas, fear patterns |
| Manual synthesis across interviews | AI-powered cross-stakeholder analysis with contradiction detection |
| No follow-up artifacts | One-click "closing the loop" documents that build credibility |
| Everything shareable or everything private | Deliberate separation with hardcoded privacy boundaries |
| Notes in scattered docs | Structured intelligence with quotes, themes, and confidence levels |

## Demo Data

The demo uses a synthetic scenario called TalentBridge: a company hiring a Head of Product AI into a politically complex environment. Six stakeholders, each with competing agendas, hidden information, and contradictory views on the same events. The scenario includes:

- A CPO positioning himself for deniability
- A VP of Sales who likely over-promised AI features to customers
- An Engineering Lead offering conditional support with a binary ultimatum
- A marginalized Data Scientist who's 2-3 months from leaving
- A Head of Customer Success who disclosed a privacy violation as a trust test
- A Warsaw Engineering Lead hiding a working prototype from London leadership

16+ contradictions across stakeholders. All surfaced automatically from interview transcripts.

## Built With

- **Claude Code** - Backend intelligence processing (slash commands, synthesis, privacy enforcement)
- **Vanilla JavaScript** - No framework. Single HTML file.
- **Tailwind CSS** - Styling via CDN
- **SVG** - Interactive matrix with drag-and-drop positioning

The entire front-end ships as one file. No build step, no dependencies, no infrastructure.

## What's Next

- **AI chat interface** - Ask natural language questions against your stakeholder data. "What does Tom think about the conference deadline?" "Where do Elena and James disagree?" The system goes to raw transcripts and synthesis to find answers with citations.
- **Live data pipeline** - Connect the Claude Code export directly to the front-end, so the visualization updates as you process new interviews.
- **Relationship timeline** - Visual history of every interaction with a stakeholder, showing how your understanding evolved over time.
- **Org context layer** - Map stakeholder views against stated company strategy (OKRs, annual plan, mission) to surface where people are misaligned with organizational goals, not just with each other.

## About

Built by [Simon Conway](https://www.linkedin.com/in/simonconway1/) - Product Manager based in Barcelona, building AI-native PM tools with Claude Code since December 2025.

This project started from a real pain point: the stakeholder interview process during PM onboarding is manual, scattered, and misses critical patterns. The First 90 Days gives you the methodology. This system gives you the infrastructure to actually execute it.
