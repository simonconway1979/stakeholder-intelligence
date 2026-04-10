#!/bin/bash
# Stakeholder Intelligence status bar script
# Called by Claude Code status line

STATS="/Users/simon/Desktop/Claude Code/projects/stakeholder-intelligence-app/context-library/memory/stats.json"

if [ ! -f "$STATS" ]; then
  echo "SI: not initialised"
  exit 0
fi

python3 - "$STATS" << 'EOF'
import sys, json

with open(sys.argv[1]) as f:
    s = json.load(f)

transcripts = s.get("transcripts", 0)
cost = s.get("total_cost_usd", 0.0)
last = s.get("last_run", "never")

t_label = f"{transcripts} transcript{'s' if transcripts != 1 else ''}"
cost_label = f"${cost:.2f}"

print(f"SI · {t_label} · {cost_label} · localhost:8080")
EOF
