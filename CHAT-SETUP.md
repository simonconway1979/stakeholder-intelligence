# Chat Setup Guide

The Ask tab uses a Cloudflare Worker to proxy requests to the Anthropic API. This keeps your API key off the client and enables prompt caching so repeated questions don't re-tokenise the full project data.

---

## How it works

1. User types a question in the browser
2. Browser POSTs `{ messages: [...] }` to your Cloudflare Worker
3. Worker adds the system prompt (with full project data embedded) and forwards to Anthropic
4. Anthropic streams the response back through the Worker as Server-Sent Events
5. Browser renders the tokens as they arrive

The project data lives inside the Worker, so the browser never sends it. Anthropic caches the system prompt across requests — after the first call, repeated questions only cost ~200 tokens each instead of thousands.

---

## Prerequisites

- [Node.js](https://nodejs.org) (for Wrangler CLI)
- A [Cloudflare account](https://cloudflare.com) (free tier is fine)
- An [Anthropic API key](https://console.anthropic.com)

---

## Deploy the Worker

### 1. Install Wrangler

```bash
npm install -g wrangler
wrangler login
```

### 2. Create a wrangler.toml

Create this file in the project root (next to `worker.js`):

```toml
name = "stakeholder-intelligence-chat"
main = "worker.js"
compatibility_date = "2024-01-01"

[vars]
# non-secret vars here if needed
```

### 3. Add your API key as a secret

```bash
wrangler secret put ANTHROPIC_API_KEY
# paste your key when prompted
```

### 4. Update CORS origin (optional but recommended)

In `worker.js`, update the `ALLOWED_ORIGINS` array to include your GitHub Pages URL:

```javascript
const ALLOWED_ORIGINS = [
  'http://localhost:8080',
  'http://127.0.0.1:8080',
  'https://yourusername.github.io',  // ← your GitHub Pages domain
];
```

### 5. Deploy

```bash
wrangler deploy
```

You'll get a URL like `https://stakeholder-intelligence-chat.yourname.workers.dev`

### 6. Configure the app

Open the app and click the **Ask** tab. Paste your worker URL:

```
https://stakeholder-intelligence-chat.yourname.workers.dev/chat
```

The URL is saved in `localStorage` — you only need to do this once per browser.

---

## Update the project data

The project data is embedded directly in `worker.js` at build time. When `data.json` changes, regenerate the worker:

```bash
cd front-end
python3 -c "
import json
with open('data.json') as f:
    d = json.load(f)
escaped = json.dumps(d, separators=(',',':')).replace('\\\\', '\\\\\\\\').replace('\`', '\\\\\`').replace('\${', '\\\\\${')
print(escaped)
" | pbcopy
```

Then paste the output to replace the `PROJECT_DATA` constant in `worker.js`, and redeploy with `wrangler deploy`.

---

## Costs

- **Cloudflare Workers free tier:** 100,000 requests/day — plenty for a demo
- **Anthropic (claude-haiku-4-5):** ~$0.001 per question after caching kicks in (first request per cold start costs more)

---

## Troubleshooting

**"Connection error" in the chat**
- Check the worker URL ends in `/chat`
- Check the worker is deployed: visit the URL in your browser (should return "Method not allowed")
- Check CORS — the `Origin` header from your browser must be in `ALLOWED_ORIGINS`

**Blank responses**
- Check your Anthropic API key: `wrangler secret list`
- Check the worker logs: `wrangler tail`

**Rate limits**
- claude-haiku-4-5 has generous rate limits; unlikely to hit them in a demo
