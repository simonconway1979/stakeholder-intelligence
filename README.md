# Stakeholder Intelligence

You join a project mid-flight. Six stakeholders. History you weren't part of. Everyone helpful, everyone with a slightly different version of events.

By week three you have notes in four places, two contradictions you've half-noticed, and a nagging feeling that someone said something important in that first meeting you've since lost.

This is the memory layer that catches you up and keeps you current.

**Stakeholder Intelligence** is a module for Claude Code PM OS users. It processes your meeting transcripts, builds a structured read of your stakeholder landscape, and — crucially — works with you to negotiate a shared view of what's actually happening. Not just what was said in the room.

**[Try the live demo →](https://simonconway1979.github.io/stakeholder-intelligence/)**

---

## What it does

### 1. Extract intelligence from transcripts

Drop a meeting transcript and it produces:

- Stakeholder profile updates (goals, needs, pain points, hidden agendas, key quotes)
- Contradictions — where this person's story doesn't match what others have said
- Hypotheses — testable beliefs about the political dynamics
- Recommendations — specific next actions with rationale

### 2. Build a negotiated view

Claude's synthesis is only as good as what was said in the room. You know things that never made it into a transcript. The thought partner layer lets you react to every insight:

| Action | What it means |
|--------|--------------|
| ✅ Accept | You agree — statement is confirmed |
| ✏️ Edit | You'd put it differently |
| ❌ Remove | You don't think this is true |
| 🔬 Hypothesise | Neither of us is sure — create a testable belief with a test condition |
| 💬 Annotate | Add context without changing the underlying read |

The most useful signal is where your gut and the data diverge. That gap is what's worth investigating.

### 3. Visualise the landscape

An interactive stakeholder matrix shows each person's influence, interest, and attitude. Drag to reposition as your read evolves. Click any stakeholder to explore their full profile, contradictions, and recommendations.

### 4. Ask questions

A built-in chat (powered by Claude) lets you think out loud with the full project data in context. Ask about a specific person, request a summary, or work through a decision.

---

## Architecture

Two layers:

**Claude Code skills** — the intelligence layer. Run in your terminal alongside your PM OS.

```
/_add-transcript     Process a meeting transcript (multi-step: project → paste → assign stakeholders)
/_add-note           Capture informal interactions (Slack, email, hallway)
/_project-synthesis  Full cross-stakeholder analysis — contradictions, hypotheses, recommendations
/_what-should-i-do-next  Generate prioritised next actions from latest synthesis
/_export-data        Export structured JSON for the web viewer
/_session-save       Save session context and progress
```

**Web viewer** — the view and thought partner layer. A single-page app served locally (or deployed to GitHub Pages for demos).

```
front-end/
├── index.html     Single-file app (Tailwind + vanilla JS)
└── data.json      Structured export from the skills layer
```

The skills write to markdown files. The viewer reads from `data.json`. File watching keeps the viewer live as skills run.

---

## Getting started

### Prerequisites

- Claude Code
- Python 3 (for local server)

### Run the demo locally

```bash
git clone https://github.com/simonconway1979/stakeholder-intelligence
cd stakeholder-intelligence/front-end
python3 -m http.server 8080
```

Open `localhost:8080`. The Talent Bridge synthetic demo is pre-loaded — six stakeholders, full political dynamics, contradictions surfaced across the landscape.

### Use it on a real project

1. Create a project folder: `projects/[project-name]/`
2. Copy the structure from `projects/_setup/`
3. Run `/_add-transcript` in Claude Code and follow the prompts
4. Run `/_project-synthesis` after 3+ transcripts
5. Open the viewer to explore and annotate

---

## Enable the Ask tab

The Ask tab uses a Cloudflare Worker to proxy Anthropic API calls — your key never touches the browser. See **[CHAT-SETUP.md](CHAT-SETUP.md)** for full instructions.

The short version:

```bash
npm install -g wrangler
wrangler deploy
# Add ANTHROPIC_API_KEY as a Secret in the Cloudflare dashboard
```

Paste your worker URL into the Ask tab setup screen. Done.

---

## Roadmap

**Now — skills**
Rewrite `/_add-transcript` as a multi-step conversational flow. Background agents so synthesis is non-blocking. Validation agents to sense-check outputs. Cost tracking per run.

**Next — desktop app**
A native app (Tauri) that wraps the viewer and adds the thought partner UI — inline annotation, accept/edit/reject/hypothesise on every statement, dialogue with Claude about disagreements. The desktop app can call the Anthropic API directly (no Cloudflare Worker needed).

**Later — integrations**
Granola transcript import via `/inbox/` drop hook. Google Meet integration (requires separate backend decision).

---

## Example project

`projects/Talent Bridge (Example)/` — a synthetic PM scenario with six stakeholders, full interview transcripts, cross-stakeholder synthesis, and 8+ surfaced contradictions. Good for exploring the system before using it on a real project.

---

## Stack

- **Skills:** Claude Code (markdown + prompt engineering)
- **Viewer:** HTML + Tailwind CSS + vanilla JS, SVG matrix, SSE streaming
- **Chat proxy:** Cloudflare Workers
- **Data:** Structured JSON with schema versioning
- **Model:** claude-sonnet-4-6 (configurable)

---

## Privacy

All project data is stored locally. Nothing is uploaded anywhere unless you deploy the chat worker (which only receives your conversation messages, not your project files — the data is embedded in the worker at deploy time).

---

*Part of the [PM Operating System for Claude Code](https://github.com/simonconway1979/PM-OS). Started March 2026.*
