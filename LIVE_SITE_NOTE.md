# Fixing the live site (jasonplusproductions.com)

**What we found:** The live site at https://jasonplusproductions.com/ is currently serving **different code** than this repo:

- Live site has "Jason Plus Ecosystem" and the **Jason Plus The MLC card has no link** (just "Coming Soon").
- This repo has working MLC nav + card (both link to https://themlc.jasonplusproductions.com with `onclick` fallback).

**To get the working MLC button and card on jasonplusproductions.com, do one of the following:**

## Option A: Use this repo as the live site (recommended)

1. Push this repo: `npm run deploy` (or `git push origin main`).
2. In GitHub: **jasonplusproductions-create/jpp-landing** → **Settings** → **Pages**:
   - **Source:** GitHub Actions.
   - **Custom domain:** set to `jasonplusproductions.com` (and add the DNS records GitHub shows).
3. After DNS propagates, jasonplusproductions.com will serve this code and the MLC nav + card will work.

## Option B: Keep the current live site’s codebase

If jasonplusproductions.com is built from another repo or platform (e.g. Netlify, another GitHub repo):

1. In **that** project, make the **nav “The MLC”** a real link:
   - `href="https://themlc.jasonplusproductions.com"` and `target="_blank"`.
   - Optional: `onclick="window.open(this.href,'_blank'); return false;"` so it still works if something blocks the default.
2. Make the **Jason Plus The MLC** card a link:
   - Wrap the card in `<a href="https://themlc.jasonplusproductions.com" target="_blank" rel="noopener noreferrer">` or add a “Visit The MLC” button that links there.

Once the live site’s HTML has those links (or points to this repo via Option A), the MLC button and card will work on jasonplusproductions.com.
