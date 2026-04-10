# Stakeholder Intelligence

**[Try the live demo →](https://simonconway1979.github.io/stakeholder-intelligence/)**

---

You join a project mid-flight. Six stakeholders. History you weren't part of. Everyone helpful, everyone with a slightly different version of events.

By week three you have notes in four places, two contradictions you've half-noticed, and a nagging feeling that someone said something important in that first meeting you've since lost.

This is the memory layer that catches you up and keeps you current.

**Stakeholder Intelligence** is a module for Claude Code PM OS users. It processes your meeting transcripts, builds a structured read of your stakeholder landscape, and works with you to negotiate a shared view of what's actually happening — not just what was said in the room.

---

## What it does

### Extract intelligence from transcripts

Drop a meeting transcript and it produces:

- Stakeholder profile updates (goals, pain points, hidden agendas, key quotes)
- Contradictions — where this person's story doesn't match what others have said
- Hypotheses — testable beliefs about the political dynamics
- Recommendations — specific next actions with rationale

### Build a negotiated view

Claude's read is only as good as what was said in the room. You know things that never make it into a transcript. The thought partner layer lets you react to every insight:

| Action | What it means |
|--------|--------------|
| ✅ Accept | You agree — statement confirmed |
| ✏️ Edit | You'd put it differently |
| ❌ Remove | You don't think this is true |
| 🔬 Hypothesise | Neither of you is sure — create a testable belief with a test condition |
| 💬 Annotate | Add context without changing the underlying read |

The most valuable signal is where your gut and the data diverge. That gap is what's worth investigating.

### Visualise the landscape

An interactive stakeholder matrix plots each person by influence and support. Click any stakeholder to explore their full profile, contradictions, and recommendations.

### Ask questions

A built-in chat (powered by Claude) lets you think out loud with the full project data in context.

---

## Architecture

**Claude Code skills** — the intelligence layer. Run in your terminal alongside your PM OS.

```
/_add-transcript     Process a meeting transcript
/_add-note           Capture informal interactions (Slack, email, hallway)
/_project-synthesis  Full cross-stakeholder analysis
/_what-should-i-do-next  Prioritised next actions from latest synthesis
/_export-data        Export structured JSON for the web viewer
```

**Web viewer** — the view and thought partner layer. Single-page app, no framework, deploys to GitHub Pages.

---

## Get started

```bash
git clone https://github.com/simonconway1979/stakeholder-intelligence
cd stakeholder-intelligence/front-end
python3 -m http.server 8080
```

Open `localhost:8080`. The Talent Bridge demo is pre-loaded — six stakeholders, full political dynamics, contradictions surfaced across the landscape.

To use it on a real project: create a folder in `projects/`, copy from `projects/_setup/`, then run `/_add-transcript` in Claude Code and follow the prompts.

---

## Privacy

All project data is stored locally. Nothing is uploaded anywhere unless you deploy the chat worker — which only receives conversation messages. Project files never leave your machine.

---

## Roadmap

**Now:** Rewrite `/_add-transcript` as a multi-step conversational flow. Background agents so synthesis is non-blocking. Cost tracking per run.

**Next:** Native desktop app (Tauri) with the full thought partner UI — inline annotation, dialogue with Claude about disagreements, direct API access without a proxy.

**Later:** Granola transcript import via `/inbox/` drop hook.

---

*Part of the [PM Operating System for Claude Code](https://github.com/simonconway1979/PM-OS). Started March 2026.*
