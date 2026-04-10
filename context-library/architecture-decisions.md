# Architecture Decisions

Decisions made about how Stakeholder Intelligence fits into the PM OS, and how the broader PM OS should evolve. Documented here so context isn't lost between sessions.

---

## 1. Stakeholder Intelligence as a module, not a standalone app

**Decision:** Stakeholder Intelligence is a module within the PM OS, not a self-contained project. It integrates with the broader Claude Code PM OS and its value compounds with the rest of the OS.

**What this means:**
- Skills live in the stakeholder-intelligence project but are designed to be portable
- The global people graph (see below) lives at root level, not inside this module
- Any PM OS project can access stakeholder intelligence — it's not locked to a single project folder

---

## 2. Global people graph at root level

**Decision:** Stakeholder profiles and memory should live at root `context-library/people/`, not inside project folders. People exist across multiple projects and their intelligence should compound over time.

**Current problem:** Stakeholders are currently scoped per-project. If Marcus Webb appears in Talent Bridge and also in a Sobremesa conversation, his profiles are separate. No cross-project pattern recognition is possible.

**Proposed structure:**
```
Claude Code/
└── context-library/
    └── people/
        └── [person-id]/
            ├── profile.md       ← Stable: name, role, background
            ├── memory.md        ← Evolving: everything known, tagged by project
            └── touchpoints.md   ← Log of all interactions across projects
```

**Project-specific context** stays in the project folder — meetings, synthesis, project-specific notes. The global profile holds what's true across all contexts.

**Synthesis promotes to global:** Not every meeting note belongs in permanent memory. `/_project-synthesis` is the quality gate — it decides what's significant enough to promote to the global people graph. This keeps global profiles signal-rich rather than noisy.

**The key benefit:** When a known person appears in a new project, they arrive with history. Patterns that only emerge across multiple contexts become visible.

**Status:** Designed, not yet implemented. Requires update to `/_add-transcript` and `/_project-synthesis` skills.

---

## 3. Projects as records, not just folders

**Decision:** A "project" should be a record with links to multiple locations, not just a single folder. The current model (project = folder) breaks when a project spans multiple parts of the OS.

**Current problem:** Sobremesa exists in two places:
- `projects/sobremesa/` — PM work (PRDs, strategy, research)
- `projects/stakeholder-intelligence-app/projects/sobremesa/` — stakeholder intelligence

These are related but currently disconnected. No single place says "here is everything about Sobremesa."

**Proposed solution:** A `projects-registry.md` at root level. Each project is a record that lists all its folder locations:

```markdown
## Sobremesa
**Status:** Active
**PM work:** projects/sobremesa/
**Stakeholder intelligence:** projects/stakeholder-intelligence-app/projects/sobremesa/
**People:** fahad-quraishi, corinne-millar
```

Skills check the registry when a project is specified, so they can pull from all relevant locations — not just the folder they're currently in.

**Longer-term direction:** The registry is a manual graph. Projects, people, companies, goals, and meetings are nodes. The registry is the right first step — it creates the structure without requiring new infrastructure. A proper database is a future-state option if the OS grows.

**Status:** Designed, not yet implemented. Do not restructure existing folders until the registry approach is built and validated.

---

## 4. Desktop app as the thought partner layer

**Decision:** A desktop app (Tauri) will eventually replace the web viewer for day-to-day use. The web viewer on GitHub Pages remains as a public demo.

**Why desktop:**
- Can call the Anthropic API directly — no Cloudflare Worker needed
- API key stored in OS keychain — more secure, simpler setup
- File system access — reads project files directly, no JSON export step
- The thought partner UI (see below) requires visual interaction that a terminal can't provide

**Why keep the web demo:**
- Public URL for sharing and recruiting beta users
- No install required for people evaluating the product
- The Cloudflare Worker + GitHub Pages setup stays in place for the demo

**Status:** Planned. Web viewer is current state. Desktop app is next major phase.

---

## 5. Thought partner layer (negotiated intelligence)

**Decision:** The app should not just present Claude's synthesis as output — it should support a dialogue between Claude's read and the user's read, producing a negotiated view.

**The problem with synthesis-as-output:** Claude's read is only as good as what was said in the room. The user knows things that never made it into a transcript. Treating Claude's output as the answer discards the user's judgment.

**The thought partner model:** Claude produces a first draft. The user reacts to every insight. The most useful signal is where the two reads diverge — that gap is what's worth investigating.

**Resolution options for each statement:**

| Action | What it means |
|--------|--------------|
| ✅ Accept | User agrees — statement confirmed |
| ✏️ Edit | User would put it differently |
| ❌ Remove | User doesn't think this is true |
| 🔬 Hypothesise | Neither is sure — create a testable belief with a test condition |
| 💬 Annotate | Add context without changing the underlying read |

**Data model:** Every synthesised statement needs a status field. Example:

```json
{
  "text": "Marcus is positioning for deniability if the AI programme fails",
  "source": "machine",
  "status": "hypothesis",
  "userNote": "Not sure — he might just be genuinely cautious",
  "testCondition": "Watch whether he publicly backs the programme before the conference"
}
```

Statuses: `unreviewed` → `accepted` / `edited` / `rejected` / `hypothesis`

**Schema must be designed before the desktop app is built.** This is a breaking change to the data model that touches stakeholder profiles, contradictions, and recommendations.

**User annotations feed back into synthesis:** When `/_project-synthesis` runs, it reads the user's annotations — not just Claude's previous output. Rejected statements are not regenerated. Hypotheses are tracked and surfaced for validation.

**Where the thought partner UI lives:** Desktop app. The comparison requires visual, inline interaction. The Ask tab handles nuanced disagreements conversationally — "I don't agree with this, let's talk about it." Both feed into the same annotation layer.

**Status:** Designed, not yet implemented. Requires schema design before any code.

---

## 6. Auto stakeholder memory, on-demand full synthesis

**Decision:** After each transcript, automatically update stakeholder memory (cheap, targeted). Full project synthesis runs on demand — prompted at end of transcript add, not automatic.

**Why:** Full Sonnet synthesis on a multi-stakeholder project costs ~$0.10–0.20 per run. Running it after every transcript compounds cost quickly. Stakeholder memory update is scoped to one person and much cheaper.

**Cost model (Sonnet 4.6):**
- Transcript processing + stakeholder memory update: ~$0.04–0.08
- Full project synthesis: ~$0.10–0.20 (prompt caching reduces this ~60% after first run)
- Target: no single skill run over $0.10

**Monitoring:** `context-library/memory/stats.json` tracks transcripts, syntheses, and total cost. Updated by skills after each run. Visible in Claude Code status bar via `si-status.sh`.

**Status:** Stats infrastructure built. Skills not yet wired to update stats.json.
